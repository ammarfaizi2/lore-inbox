Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266671AbUGKXoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266671AbUGKXoY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 19:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUGKXoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 19:44:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:987 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266671AbUGKXoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 19:44:22 -0400
Date: Mon, 12 Jul 2004 01:44:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: A1tmblwd@netscape.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] floppy.c: remove superfluous variable initialization
Message-ID: <20040711234419.GG4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One month ago, Kam Leo <A1tmblwd@netscape.net> sent this trivial patch 
with the following comment:


<--  snip  -->

Paul Slootman did not remove the superfluous variable 
initialization which masked the floppy minor bug in 
drivers/block/floppy.c.  Please add the patch below 
and close Bug 2770.

<--  snip  -->


Since this is obviously correct, the patch rediffed against 2.6.7-mm7 is 
below.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full/drivers/block/floppy.c.old	2004-07-12 01:33:30.000000000 +0200
+++ linux-2.6.7-mm7-full/drivers/block/floppy.c	2004-07-12 01:33:45.000000000 +0200
@@ -4228,7 +4228,6 @@
 	int err, dr;
 
 	raw_cmd = NULL;
-	i = 0;
 
 	for (dr = 0; dr < N_DRIVE; dr++) {
 		disks[dr] = alloc_disk(1);

