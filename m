Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276246AbRI1TEo>; Fri, 28 Sep 2001 15:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRI1TEf>; Fri, 28 Sep 2001 15:04:35 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:64509 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S276246AbRI1TEQ>;
	Fri, 28 Sep 2001 15:04:16 -0400
From: thunder7@xs4all.nl
Date: Fri, 28 Sep 2001 21:03:55 +0200
To: linux-kernel@vger.kernel.org
Subject: floppy hang with 2.4.9-ac1x
Message-ID: <20010928210355.A2837@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using mtools, such as mdir and mformat, under 2.4.9-ac16 (from
2.4.9-ac10 onwards, IIRC) hard-hangs my linux system....

dual P3/700, SMP kernel, gcc-3.0.1, Abit VP6 with VIA 694X chipset,
mtools-3.9.7

dmesg about the floppy:

Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077

/proc/dma:
 4: cascade

/proc/interrupts:

           CPU0       CPU1       
  0:      42356      44396    IO-APIC-edge  timer
  1:       2122       3557    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          3    IO-APIC-edge  rtc
 14:       6150       3406    IO-APIC-edge  ide0
 16:         33         32   IO-APIC-level  sym53c8xx
 17:         23         21   IO-APIC-level  sym53c8xx, sym53c8xx, EMU10K1
 18:      12680      12663   IO-APIC-level  ide2, ide3, DE500-AA (eth0)
 19:          0          0   IO-APIC-level  usb-uhci, usb-uhci
NMI:          0          0 
LOC:      86651      86651 
ERR:          0
MIS:          0

The floppy-drive itself functions quite well in DOS, so it's not that.

The symptoms are easy to describe:

the console hangs, and switching to another doesn't work. Also the
num-lock key is dead. The floppy light stays on, but it doesn't sound
like it is doing anything but spinning the motor.
There are no messages in the system logs.

Any hints on what to do?

Thanks,
Jurriaan
-- 
Cadets were humping in the corridors, a party of outraged Senators roamed
Krane barracks, everyone, including me, questioned orders, ...
Law and order.
	David Feintuch - Fisherman's Hope.
GNU/Linux 2.4.9-ac16 SMP/ReiserFS 2x1402 bogomips load av: 0.00 0.03 0.04
