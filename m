Return-Path: <linux-kernel-owner+w=401wt.eu-S1750878AbXAOVY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbXAOVY3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbXAOVY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:24:28 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:48319
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbXAOVY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:24:28 -0500
From: Rob Landley <rob@landley.net>
Subject: [PATCH] sed s/gawk/awk/ scripts/gen_init_ramfs.sh
Date: Mon, 15 Jan 2007 16:24:17 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: "Undisclosed.Recipients":;
Message-Id: <200701151624.18033.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Landley <rob@landley.net>

Use "awk" instead of "gawk".

-- 

There's a symlink from awk to gawk if you're using the gnu tools, but no
symlink from gawk to awk if you're using BusyBox or some such.  (There's a
reason for the existence of standard names.  Can we use them please?)

--- linux-2.6.19.2/scripts/gen_initramfs_list.sh	2007-01-10 14:10:37.000000000 -0500
+++ linux-new/scripts/gen_initramfs_list.sh	2007-01-15 10:14:41.000000000 -0500
@@ -121,9 +121,9 @@
 		"nod")
 			local dev_type=
 			local maj=$(LC_ALL=C ls -l "${location}" | \
-					gawk '{sub(/,/, "", $5); print $5}')
+					awk '{sub(/,/, "", $5); print $5}')
 			local min=$(LC_ALL=C ls -l "${location}" | \
-					gawk '{print $6}')
+					awk '{print $6}')
 
 			if [ -b "${location}" ]; then
 				dev_type="b"
@@ -134,7 +134,7 @@
 			;;
 		"slink")
 			local target=$(LC_ALL=C ls -l "${location}" | \
-					gawk '{print $11}')
+					awk '{print $11}')
 			str="${ftype} ${name} ${target} ${str}"
 			;;
 		*)

-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
