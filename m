Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbRCaJ7r>; Sat, 31 Mar 2001 04:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132362AbRCaJ7i>; Sat, 31 Mar 2001 04:59:38 -0500
Received: from c213.89.109.26.cm-upc.chello.se ([213.89.109.26]:12548 "EHLO
	pescadero.ampr.org") by vger.kernel.org with ESMTP
	id <S132359AbRCaJ7Z>; Sat, 31 Mar 2001 04:59:25 -0500
Message-ID: <3AC5AA35.24A6320A@ufh.se>
Date: Sat, 31 Mar 2001 11:58:14 +0200
From: Peter Enderborg <pme@ufh.se>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Version 6.1.6 of the aic7xxx driver availalbe
In-Reply-To: <200103100336.f2A3ZqO67658@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded to 2.4.3 from 2.4.1 today and I get a lot of recovery on the scsi
bus.
I also upgraded to the "latest" aic7xxx driver but still the sam problems.
A typical revery in my logs.
Mar 31 09:34:35 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:34:35 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 09:34:35 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 09:34:35 pescadero kernel: Recovery code sleeping
Mar 31 09:34:40 pescadero kernel: Recovery code awake
Mar 31 09:34:40 pescadero kernel: Timer Expired
Mar 31 09:34:40 pescadero kernel: aic7xxx_abort returns 8195
Mar 31 09:34:40 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:34:40 pescadero kernel: Recovery SCB completes
Mar 31 09:34:40 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 09:34:40 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 09:34:40 pescadero kernel: Recovery code sleeping
Mar 31 09:34:40 pescadero kernel: Recovery code awake
Mar 31 09:34:40 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:34:50 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:34:50 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 09:34:50 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:34:50 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:34:50 pescadero kernel: scsi0:0:4:0: Device is active, asserting
ATN
Mar 31 09:34:50 pescadero kernel: Recovery code sleeping
Mar 31 09:34:55 pescadero kernel: Recovery code awake
Mar 31 09:34:55 pescadero kernel: Timer Expired
Mar 31 09:34:55 pescadero kernel: aic7xxx_abort returns 8195
Mar 31 09:34:55 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:34:55 pescadero kernel: Recovery SCB completes
Mar 31 09:34:55 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 09:34:55 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 09:34:55 pescadero kernel: Recovery code sleeping
Mar 31 09:34:55 pescadero kernel: Recovery code awake
Mar 31 09:34:55 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:05 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:05 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 09:35:05 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:05 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:05 pescadero kernel: Recovery SCB completes
Mar 31 09:35:05 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 09:35:05 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 09:35:05 pescadero kernel: Recovery code sleeping
Mar 31 09:35:05 pescadero kernel: Recovery code awake
Mar 31 09:35:05 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:15 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:15 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 09:35:15 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:15 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:15 pescadero kernel: Recovery SCB completes
Mar 31 09:35:15 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 09:35:15 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 09:35:15 pescadero kernel: Recovery code sleeping
Mar 31 09:35:15 pescadero kernel: Recovery code awake
Mar 31 09:35:15 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:25 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:25 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 09:35:25 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:25 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:25 pescadero kernel: Recovery SCB completes
Mar 31 09:35:25 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 09:35:25 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 09:35:25 pescadero kernel: Recovery code sleeping
Mar 31 09:35:25 pescadero kernel: Recovery code awake
Mar 31 09:35:25 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:35 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:35 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 09:35:35 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:35 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:35 pescadero kernel: Recovery SCB completes
Mar 31 09:35:35 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 09:35:35 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 09:35:35 pescadero kernel: Recovery code sleeping
Mar 31 09:35:35 pescadero kernel: Recovery code awake
Mar 31 09:35:35 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:45 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:45 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 09:35:45 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:45 pescadero kernel: scsi0:0:4:0: Attempting to queue a TARGET
RESET message
Mar 31 09:35:45 pescadero kernel: scsi0:0:4:0: Command not found
Mar 31 09:35:45 pescadero kernel: aic7xxx_dev_reset returns 8194
Mar 31 09:35:55 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 09:35:55 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 09:35:55 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 09:35:55 pescadero kernel: Recovery SCB completes
Mar 31 09:35:55 pescadero kernel: Recovery SCB completes
Mar 31 09:36:00 pescadero kernel: Device not ready.  Make sure there is a
disc in the drive.



This is runing on asus p2b-ds aic7890
[root@pescadero /root]# cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 6.1.8
aic7890/91: Wide Channel A, SCSI Id=7, 32/255 SCBs
Channel A Target 0 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 1 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
        Goal: 20.000MB/s transfers (20.000MHz, offset 15)
        Curr: 20.000MB/s transfers (20.000MHz, offset 15)
        Channel A Target 3 Lun 0 Settings
                Commands Queued 5
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
        Channel A Target 4 Lun 0 Settings
                Commands Queued 16992
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 5 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
[root@pescadero /root]#


With shared interrupts
[root@pescadero /root]# cat /proc/interrupts
           CPU0       CPU1
  0:      69150      68767    IO-APIC-edge  timer
  1:       1539       1510    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:          0          0   IO-APIC-level  rme9652
  7:         15         34    IO-APIC-edge  serial
  8:          0          1    IO-APIC-edge  rtc
 12:      15363      16263    IO-APIC-edge  PS/2 Mouse
 14:      18794      19142    IO-APIC-edge  ide0
 16:       1433       1280   IO-APIC-level  eth0
 17:      13233      11878   IO-APIC-level  Trident Audio
 18:       8480       8716   IO-APIC-level  aic7xxx, usb-uhci, eth1, Ensoniq
AudioPCI
NMI:          0          0
LOC:     137823     137842
ERR:          0
[root@pescadero /root]#

Any ideas what could be wrong ?

