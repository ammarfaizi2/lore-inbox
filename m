Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261637AbRESCox>; Fri, 18 May 2001 22:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbRESCon>; Fri, 18 May 2001 22:44:43 -0400
Received: from mail.hiscs.org ([206.170.178.6]:62957 "EHLO mail.hiscs.org")
	by vger.kernel.org with ESMTP id <S261637AbRESCob>;
	Fri, 18 May 2001 22:44:31 -0400
Message-ID: <3B05DD6E.15320298@users.sourceforge.net>
Date: Fri, 18 May 2001 19:41:50 -0700
From: Josh Green <jgreen@users.sourceforge.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Noticeable latency problems after upgrade from 2.4.3 to 2.4.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing nasty latency problems (stalls X cursor, Maelstrom
arcade game :), etc) with Linux kernel 2.4.4. I did not have this
problem with 2.4.3. I have Mandrake 8.0. I made sure that I compiled the
2.4.4 kernel with the older egcs 1.1.2 (although I did try it with the
controversial gcc 2.96 with the same results). 
Both kernels were downloaded off of kernel.org (not Mandrake modified)
and I used the same .config.
Heres a description of my system:

I'm using reiserfs
Linux version 2.4.4 (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2
release / Linux-Mandrake 8.0))
XFree86 4.0.3
CPU: AMD K6 550 MHZ
Memory: 128 MB
HD: WDC WD300BB-00AUA1, ATA IDE DISK drive
Chipset: VIA VT82C586

Both kernels had the following hard disk tuning parameters (excerpt from
hdparm):
/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)

I even set the multcount to 8 with a slight increase in hdparm -t read
performance, but still bad latency.
The latency issues mainly occur with compiling programs. Compiling my
autoconf based program and running Maelstrom at the same time served as
a crude test. 2.4.4 would have large skip outs in sound and pauses in
gameplay, whereas 2.4.3 runs very smooth. I also did an hdparm -t while
running tests, I did not perceive the problem in this case though,
suggesting something besides hard disk access.

If anyone has any info on what could be causing this, please let me
know. CC me as I'm not on the list. If there isn't any knowledge of this
problem, I will try to track it down myself. I guess perhaps narrowing
it down to a particular pre version and maybe doing some kernel
profiling (I have no idea how) if all else fails. Lates..
	Josh Green
