Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292985AbSCAMPo>; Fri, 1 Mar 2002 07:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293037AbSCAMPd>; Fri, 1 Mar 2002 07:15:33 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:2176 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S293015AbSCAMPZ>;
	Fri, 1 Mar 2002 07:15:25 -0500
Date: Fri, 1 Mar 2002 13:14:41 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.6-pre2 dparent_lock
Message-ID: <20020301121441.GA1566@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I did not notice anybody reporting this yet. Without this fs 
modules refuse to load to 2.5.6-pre2 due to missing dparent_lock
symbol. Tested with vfat and ncpfs.
				Petr Vandrovec
				vandrove@vc.cvut.cz


* Export dparent_lock symbol.

diff -urdN linux/kernel/ksyms.c linux/kernel/ksyms.c
--- linux/kernel/ksyms.c	Fri Mar  1 11:23:55 2002
+++ linux/kernel/ksyms.c	Fri Mar  1 12:03:57 2002
@@ -285,6 +285,7 @@
 EXPORT_SYMBOL(get_sb_bdev);
 EXPORT_SYMBOL(get_sb_nodev);
 EXPORT_SYMBOL(get_sb_single);
+EXPORT_SYMBOL(dparent_lock);
 
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);
