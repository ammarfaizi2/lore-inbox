Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261602AbTCKVG0>; Tue, 11 Mar 2003 16:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbTCKVG0>; Tue, 11 Mar 2003 16:06:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4333 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261602AbTCKVGY>;
	Tue, 11 Mar 2003 16:06:24 -0500
Date: Tue, 11 Mar 2003 21:17:00 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: gerg@snapgear.com, linux-kernel@vger.kernel.org
Subject: Please revert second addition of stddef.h to list.h
Message-ID: <20030311211700.GI16414@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I read these things on the web so I dunno how to specify a BK command
to do what needs to be done, but this cset:

http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-1.1137.txt

is obviously wrong.

diff -Nru a/include/linux/list.h b/include/linux/list.h
--- a/include/linux/list.h	Tue Mar 11 11:08:20 2003
+++ b/include/linux/list.h	Tue Mar 11 11:08:20 2003
@@ -3,6 +3,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/stddef.h>
 #include <linux/prefetch.h>
 #include <linux/stddef.h>
 #include <asm/system.h>


-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
