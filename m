Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRDCH7t>; Tue, 3 Apr 2001 03:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDCH7j>; Tue, 3 Apr 2001 03:59:39 -0400
Received: from cp31483-a.dbsch1.nb.nl.home.com ([217.120.33.210]:41989 "EHLO
	CP31483-A.dbsch1.nb.nl.home.com") by vger.kernel.org with ESMTP
	id <S130317AbRDCH7b>; Tue, 3 Apr 2001 03:59:31 -0400
Date: Tue, 3 Apr 2001 09:59:24 +0200 (CEST)
From: Erik Oomen <erik.oomen@home.nl>
X-X-Sender: <oomen@CP31483-A.dbsch1.nb.nl.home.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: oops in uhci.c running 2.4.2-ac28
In-Reply-To: <20010402195048.H17651@sventech.com>
Message-ID: <Pine.LNX.4.33.0104030954440.1728-100000@CP31483-A.dbsch1.nb.nl.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2001, Johannes Erdfelt wrote:

> > Let me show what I got with the 2.4.2 kernel with USB support enabled.
> >
> > Mar 19 14:10:00 Eng99 kernel: uhci: host controller halted. very bad

I am having the same problem with kernel 2.4.3 on a Intel 430TX system:

** Last lines of DMESG:

uhci.c: suspend_hc
uhci: host controller halted. very bad
uhci.c: wakeup_hc

** lspci
root@immtng:/home/oomen > lspci
00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
00:01.0 VGA compatible controller: Chips and Technologies F69000 HiQVideo
(rev 64)
00:02.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
00:04.0 Bridge: Tundra Semiconductor Corp. CA91C042 [Universe] (rev 02)
00:05.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c860
(rev 02)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)

** lsmod
root@immtng:/home/oomen > lsmod
Module                  Size  Used by
uhci                   18736   0  (unused)
universe               83728   0
sym53c8xx              55904   0  (unused)
usbcore                51088   0  [uhci]
tulip                  34880   1
serial                 43568   0  (autoclean)

** cat /proc/cpuinfo
root@immtng:/home/oomen > cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 8
model name      : Mobile Pentium MMX
stepping        : 1
cpu MHz         : 267.278
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 532.48

Erik.

