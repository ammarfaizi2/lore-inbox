Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbTBCOhp>; Mon, 3 Feb 2003 09:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbTBCOhp>; Mon, 3 Feb 2003 09:37:45 -0500
Received: from [205.205.44.10] ([205.205.44.10]:53005 "EHLO
	sembo111.teknor.com") by vger.kernel.org with ESMTP
	id <S266431AbTBCOho>; Mon, 3 Feb 2003 09:37:44 -0500
Message-ID: <5009AD9521A8D41198EE00805F85F18F219C25@sembo111.teknor.com>
From: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
To: high-res-timers-discourse@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Unexpected lock during "Calibrating delay loop" and failure to co
	mpile without "HighRes"
Date: Mon, 3 Feb 2003 09:47:15 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I'm trying to integrate some tools on a 486-powered cpu board, I don't
really need "High Resolution Timers", but one of the tools would really make
good use of the POSIX API you implemented. I've patch kernel 2.4.20 with the
latest 2.4.20-1.0 hrtimers.

Here comes the trouble.

- Trying to build with High-Res, the kernel won't build

time.c: In function `time_init':
time.c:873: `do_fast_gettimeoffset' undeclared (first use in this function)
time.c:873: (Each undeclared identifier is reported only once
time.c:873: for each function it appears in.)
make[1]: *** [time.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

seems like it should try to link "do_slow_gettimeoffset" instead since 486
does not handle TSC, (I'll have to check that..)


- Trying to boot with "PIT-based" high-res support, the kernel lock during
calibration "Calibrating delay loop".
	Same occurs with IOAPIC and TSC ... 


If you have any hint, I'll be glad to hear it.

Thanks


Frank

