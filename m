Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbRBWFjE>; Fri, 23 Feb 2001 00:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRBWFiy>; Fri, 23 Feb 2001 00:38:54 -0500
Received: from mail23.bigmailbox.com ([209.132.220.203]:19207 "EHLO
	mail23.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S131410AbRBWFip>; Fri, 23 Feb 2001 00:38:45 -0500
Date: Thu, 22 Feb 2001 21:38:39 -0800
Message-Id: <200102230538.VAA17793@mail23.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [24.5.157.48]
From: "Quim K Holland" <qkholland@my-deja.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: cpu_has_fxsr or cpu_has_xmm?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at various -ac patches for the last couple of 
weeks and have been wondering why only this piece of difference
still remains between Linus' 2.4.2 and Alan's -ac2.  All the other
diffs in i387.c from 2.4.1-ac2 seem to have been merged into Linus
tree at around 2.4.2-pre1.  Could anybody explain it for me please?

--- linux.vanilla/arch/i386/kernel/i387.c       Thu Feb 22 09:05:35 2001
+++ linux.ac/arch/i386/kernel/i387.c    Sun Feb  4 10:58:36 2001
@@ -179,7 +179,7 @@
 
 unsigned short get_fpu_mxcsr( struct task_struct *tsk )
 {
-       if ( cpu_has_fxsr ) {
+       if ( cpu_has_xmm ) {
                return tsk->thread.i387.fxsave.mxcsr;
        } else {
                return 0x1f80;


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


