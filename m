Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271918AbRIIHLx>; Sun, 9 Sep 2001 03:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271919AbRIIHLm>; Sun, 9 Sep 2001 03:11:42 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:20777 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S271918AbRIIHL0>; Sun, 9 Sep 2001 03:11:26 -0400
Date: Sun, 9 Sep 2001 09:11:26 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: Aha1542 problem
Message-ID: <20010909091126.O22352@mandel.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13-current-20010108i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

unrelated to any other event, my aha1542b starts to fail. I find messages
like these below in my log. Unloading and reloading the driver helps, but
only for a short time.

HACC <4>aha1542.c: interrupt received, but no mail.
aha1542.c: Unable to abort command for target 0
aha1542.c: Trying device reset for target 0
HACC <4>aha1542.c: interrupt received, but no mail.
HACC <4>aha1542.c: interrupt received, but no mail.
aha1542.c: Unable to abort command for target 0
Sent BUS RESET to scsi host 0
aha1542.c: interrupt received, but no mail.
scsi: device set offline - not ready or command retry failed after host reset: host 0 channel 0 id 0 lun 0
st0: Error 2 (sugg. bt 0x0, driver bt 0x0, host bt 0x0).
scsi : 0 hosts left.

System: Dual P-200 MMX, Kernel 2.4.8-pre3 with ext3 patch.

/proc/interrupts:
           CPU0       CPU1       
  0:   57555063   58669574    IO-APIC-edge  timer
  1:          0          2    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:          1          3    IO-APIC-edge  serial
  8:         26         30    IO-APIC-edge  rtc
 10:     339970     351627    IO-APIC-edge  aha1542
 17:    5557414    5562660   IO-APIC-level  ide0
 18:   13365797   13366581   IO-APIC-level  eth0
NMI:          0          0 
LOC:  116232016  116232731 
ERR:          0
MIS:          0

/proc/scsi/scsi:
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TANDBERG Model:  TDC 4222        Rev: =07:
  Type:   Sequential-Access                ANSI SCSI revision: 02


Thanks,
hjb
-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/
