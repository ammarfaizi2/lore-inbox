Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbSK2Sml>; Fri, 29 Nov 2002 13:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbSK2Sml>; Fri, 29 Nov 2002 13:42:41 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:20754 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S267125AbSK2Smk> convert rfc822-to-8bit;
	Fri, 29 Nov 2002 13:42:40 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.50] uninitialized timer 
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Fri, 29 Nov 2002 18:58:16 +0100
Message-ID: <87n0nsqmvb.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Booting 2.2.50 gives:

vesafb: framebuffer at 0xe0000000, mapped to 0xc680d000, size 1984k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:8e10
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc0249c20, data=0x0
Call Trace: [<c011deb0>]  [<c0249c20>]  [<c011def7>]  [<c024a003>]
[<c021855f>]  [<c0249409>]  [<c0105086>]  [<c0105058>]  [<c0106e6d>]
Console: switching to colour frame buffer device 128x48

Passed through ksymoops I get:

ksymoops 2.4.6 on i686 2.5.50.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.50/ (default)
     -m /boot/System.map-2.5.50 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace: [<c011deb0>]  [<c0249c20>]  [<c011def7>]  [<c024a003>]  [<c021855f>]  [<c0249409>]  [<c0105086>]  [<c0105058>]  [<c0106e6d>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c011deb0 <check_timer_failed+40/4c>
Trace; c0249c20 <cursor_timer_handler+0/28>
Trace; c011def7 <add_timer+3b/120>
Trace; c024a003 <fbcon_startup+43/4c>
Trace; c021855f <take_over_console+17/18c>
Trace; c0249409 <register_framebuffer+181/1cc>
Trace; c0105086 <init+2e/178>
Trace; c0105058 <init+0/178>
Trace; c0106e6d <kernel_thread_helper+5/c>

2 warnings and 1 error issued.  Results may not be reliable.

Hope that helps.

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.

