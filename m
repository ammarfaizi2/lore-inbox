Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTEDVJP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTEDVJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:09:15 -0400
Received: from main.davidkarlsen.com ([217.13.8.30]:63655 "EHLO skunk")
	by vger.kernel.org with ESMTP id S261727AbTEDVJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:09:13 -0400
Message-ID: <3EB58465.1070902@davidkarlsen.com>
Date: Sun, 04 May 2003 23:21:41 +0200
From: "David J. M. Karlsen" <david@davidkarlsen.com>
Organization: davidkarlsen.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: nb, no, nn, en
MIME-Version: 1.0
To: Benson Chow <blc@q.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v4l bttv bt878 PCI on VIA KT133 chipset crashes?
References: <Pine.LNX.4.44.0304050045090.16146-100000@q.dyndns.org>
In-Reply-To: <Pine.LNX.4.44.0304050045090.16146-100000@q.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benson Chow wrote:
> Just wonderring.
> 
> I'm getting weird crashes with running the bttv driver that comes with
> 2.4.20 (0.7.96?) with a bt878 card.  I can record fine from it, can change
> channels, etc. - Great.  Except if I keep on starting and stopping
> mencoder (opening and closing /dev/video), it usually works for a few
> times from a fresh reboot just fine, but after 5 times (and it's random,
> it may not start till after 20 times) it *seems* other parts of kernel
> space gets badly corrupted.  My kswapd oopses and dies.  Processes
> cause oopses for no reason.  The oopses tend to occur in disk i/o
> routines, not in the bttv driver for some reason, and after the corruption
> (?) occurs, all processes can and will die.  The machine eventually goes
> down hard needing a jab at the case  Not exactly a graceful shutdown!  The
> machine seems to work fine if I never use the video capture card, even
> thrashing disk and flooding the PCI network card seems to work fine.
I had problems with 2.4.20 with the same hardware and using the program 
zapping for viewing. My box just froze. I thought maybe it was caused by 
sharing interrupts - but the machine hasn't frozen yet when I switched 
over to using xawtv instead.


ints:
david@skunk:~$ cat /proc/interrupts
            CPU0
   0:   29393376          XT-PIC  timer
   1:         32          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:    3529723          XT-PIC  ide2, ide3, bttv
   8:          4          XT-PIC  rtc
  10:     119935          XT-PIC  usb-uhci, usb-uhci, advansys
  11:    2597210          XT-PIC  via82cxxx, aic7xxx, eth0
  14:    2243192          XT-PIC  ide0
  15:    2136742          XT-PIC  ide1
NMI:          0
LOC:   29394447
ERR:       8021
MIS:          0
david@skunk:~$


HW:
david@skunk:~$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
AC97 Audio Controller (rev 50)
00:08.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
(rev 01)
00:09.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
00:0a.0 SCSI storage controller: Advanced System Products, Inc ABP940-U 
/ ABP960-U (rev 03)
00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 74)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP 
(rev 82)
david@skunk:~$ lspci



-- 
David J. M. Karlsen - +47 90 68 22 43
http://www.davidkarlsen.com
http://mp3.davidkarlsen.com

