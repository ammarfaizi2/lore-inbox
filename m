Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVDTRPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVDTRPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVDTRPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:15:06 -0400
Received: from ns1.coraid.com ([65.14.39.133]:13736 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261731AbVDTRPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:15:01 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
References: <874qe1pejv.fsf@coraid.com>
Subject: [PATCH 2.6.12-rc2] aoe [2/6]: aoe-stat should work for built-in as
 well as module
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 20 Apr 2005 13:05:36 -0400
Message-ID: <87u0m1nztr.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aoe-stat should work for built-in as well as module

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/Documentation/aoe/status.sh b/Documentation/aoe/status.sh
--- a/Documentation/aoe/status.sh	2005-04-20 11:40:55.000000000 -0400
+++ b/Documentation/aoe/status.sh	2005-04-20 11:42:20.000000000 -0400
@@ -14,10 +14,6 @@ test ! -d "$sysd/block" && {
 	echo "$me Error: sysfs is not mounted" 1>&2
 	exit 1
 }
-test -z "`lsmod | grep '^aoe'`" && {
-	echo  "$me Error: aoe module is not loaded" 1>&2
-	exit 1
-}
 
 for d in `ls -d $sysd/block/etherd* 2>/dev/null | grep -v p` end; do
 	# maybe ls comes up empty, so we use "end"


-- 
  Ed L. Cashin <ecashin@coraid.com>

