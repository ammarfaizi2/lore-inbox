Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbUJ0NVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUJ0NVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUJ0NRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:17:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21668 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262430AbUJ0NIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:08:12 -0400
Date: Wed, 27 Oct 2004 14:08:06 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: olh@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix O= build
Message-ID: <20041027130806.GI3450@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Olaf tells me make O= has been broken for a week.  Here's the patch I've
been using to fix it:

diff -urpNX dontdiff linus-2.6/usr/Makefile parisc-2.6/usr/Makefile
--- linus-2.6/usr/Makefile	Thu Oct 21 14:40:04 2004
+++ parisc-2.6/usr/Makefile	Thu Oct 21 15:10:40 2004
@@ -8,7 +8,7 @@ clean-files := initramfs_data.cpio.gz
 # If you want a different list of files in the initramfs_data.cpio
 # then you can either overwrite the cpio_list in this directory
 # or set INITRAMFS_LIST to another filename.
-INITRAMFS_LIST := $(obj)/initramfs_list
+INITRAMFS_LIST := $(srctree)/$(obj)/initramfs_list
 
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
