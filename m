Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbSKWAlC>; Fri, 22 Nov 2002 19:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbSKWAlC>; Fri, 22 Nov 2002 19:41:02 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:182 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266210AbSKWAlB>; Fri, 22 Nov 2002 19:41:01 -0500
Subject: APIC error on CPU1: 80(00)
From: Emmanuel Fuste <e.fuste@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1038013505.1361.6.camel@rafale.worldnet.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 23 Nov 2002 02:05:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just try vmware on my computer (old bi-pentium 233) and when I start
the virtual machine, I get constant flood of :

....
APIC error on CPU1: 80(00)
APIC error on CPU1: 80(00)
APIC error on CPU1: 80(00)
APIC error on CPU1: 80(00)
APIC error on CPU1: 80(00)
APIC error on CPU1: 80(00)
APIC error on CPU1: 80(00)
....

(and the machine became very slow)

cat /proc/interrupts 
           CPU0       CPU1       
  0:     398166     411063    IO-APIC-edge  timer
  1:       1853       1831    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:          3          0    IO-APIC-edge  serial
  5:       1018        914    IO-APIC-edge  SoundBlaster
  6:         67         69    IO-APIC-edge  floppy
  8:     773092     836563    IO-APIC-edge  rtc
 12:     109641     113068    IO-APIC-edge  PS/2 Mouse
 19:      94973      95335   IO-APIC-level  aic7xxx, usb-uhci, PCnet/PCI
79C970
NMI:          0          0 
LOC:     809172     809162 
ERR:   16097271
MIS:          0

reading the sources tel me thet 80 is illegal register address.

It is a vmware bug ? or a kernel bug?

My kernel is 2.4.20-rc1.

Thanks.


Ps: please cc.
-- 
Emmanuel Fuste <e.fuste@wanadoo.fr>

