Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279856AbRKIMRV>; Fri, 9 Nov 2001 07:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279857AbRKIMRL>; Fri, 9 Nov 2001 07:17:11 -0500
Received: from [210.145.195.3] ([210.145.195.3]:128 "HELO achurch.org")
	by vger.kernel.org with SMTP id <S279856AbRKIMQ6>;
	Fri, 9 Nov 2001 07:16:58 -0500
From: achurch@achurch.org (Andrew Church)
To: linux-kernel@vger.kernel.org
Subject: BUG(?): kswapd eating CPU
Date: Fri, 09 Nov 2001 20:53:23 JST
Content-Type: text/plain; charset=ISO-2022-JP
X-Mailer: MMail v4.98
Message-ID: <3bebc95c.01056@achurch.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     I just had a strange case where kswapd started eating up 100% CPU
time.  I haven't been able to reproduce it, but it seemed to occur when I
did a "dd bs=4096 </dev/fb0 >/scratch/image" in X while writing a CD (4x)
from the same filesystem--the dd took 10-20 times longer than usual, and
kswapd's run time from ps also pointed to the same time.  At the time,
roughly 6MB of real memory was free, but most in-use memory (~800MB) was
cached data; only 3MB or so of swap was used.  The system itself seemed to
remain stable, though I rebooted shortly after I discovered the problem.

     System is as follows: (if more info is desired, please contact me
directly at achurch@achurch.org--I'm not subscribed to the list)

Kernel: 2.4.13 (i686, SMP)
CPU   : Dual Pentium II 400MHz
Memory: 896MB RAM, 576MB swap
IDE   : 1 HD (data, including /scratch, and 512MB swap)
SCSI  : 1 HD (root and 64MB swap), 1 CD-R drive
Video : 3dfx Voodoo 3 (PCI), 16MB VRAM (3dfx framebuffer driver enabled
	for virtual consoles, but X hits the hardware directly)

  --Andrew Church
    achurch@achurch.org
    http://achurch.org/
