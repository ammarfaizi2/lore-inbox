Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129271AbRBPMWQ>; Fri, 16 Feb 2001 07:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRBPMWH>; Fri, 16 Feb 2001 07:22:07 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:39689 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129355AbRBPMWD>; Fri, 16 Feb 2001 07:22:03 -0500
Message-ID: <3A8D1B6B.E9CAD752@Hell.WH8.TU-Dresden.De>
Date: Fri, 16 Feb 2001 13:22:03 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Spurious interrupts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

After modifying some bios settings and assigning the parallel port
IRQ5 instead of the IRQ7 it formerly had, I'm now getting kernel
messages like this:

spurious 8259A interrupt: IRQ7

IRQ7 is not in use by any device, but interrupts occur.

Can someone tell me what's up with that?

-Udo.

--

/proc/interrupts:

           CPU0
  0:      34556          XT-PIC  timer
  1:        934          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       1340          XT-PIC  serial
  5:          1          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:        308          XT-PIC  eth0, bttv
 10:      65134          XT-PIC  ide0
 11:          0          XT-PIC  EMU10K1
 12:       3126          XT-PIC  PS/2 Mouse
 14:          5          XT-PIC  ide2
NMI:          0
LOC:      34523
ERR:          9

procinfo:

Linux 2.4.1-ac15 (root@Corona) (gcc 2.95.2 19991024 ) #1 Fri Feb 16 08:36:50 CET 2001 1CPU 
 
Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:        255552      252180        3372           0      100704       84888
Swap:       524152        1436      522716
 
Bootup: Fri Feb 16 13:14:08 2001    Load average: 1.11 0.90 0.42 2/71 246
 
user  :       0:00:16.57   4.4%  page in :   432579
nice  :       0:03:28.11  55.0%  page out:     3564
system:       0:00:18.43   4.9%  swap in :      816
idle  :       0:02:15.58  35.8%  swap out:     1381
uptime:       0:06:18.68         context :   187481
 
irq  0:     37869 timer                 irq  8:         1 rtc
irq  1:      1141 keyboard              irq  9:       335 eth0, bttv
irq  2:         0 cascade [4]           irq 10:     65145 ide0
irq  3:      1550 serial                irq 11:         0 EMU10K1
irq  5:         1 parport0 [3]          irq 12:      4248 PS/2 Mouse
irq  6:         2                       irq 14:         5 ide2
irq  7:        10
