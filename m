Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbSJZUm5>; Sat, 26 Oct 2002 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbSJZUm5>; Sat, 26 Oct 2002 16:42:57 -0400
Received: from dhcp-209-54-75-71.ct.dsl.ntplx.com ([209.54.75.71]:3200 "EHLO
	stinkfoot.org") by vger.kernel.org with ESMTP id <S261514AbSJZUmz>;
	Sat, 26 Oct 2002 16:42:55 -0400
Message-ID: <3DBAFFC2.4070309@stinkfoot.org>
Date: Sat, 26 Oct 2002 16:49:06 -0400
From: Ethan <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: >2 AIC7xxx (29160) fails on PPC 2.4.20-preXX-ben0
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently attempted to add an additional adaptec-29160 card to my dual 
G4 (rootfs boots off one already).  It failed miserably to say the 
least.  Using an older card (adaptec 2940uw) instead does work however. 
 The kernels in question are: 2.4.20-pre11-ben0 and 2.4.20-pre7-ben0. 
 Here's what happens:
.....
ct 26 16:19:24 spicymeatball kernel: SCSI subsystem driver Revision: 1.00
Oct 26 16:19:24 spicymeatball kernel: PCI: Enabling bus mastering for 
device 10:14.0
Oct 26 16:19:24 spicymeatball kernel: scsi0 : Adaptec AIC7XXX 
EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Oct 26 16:19:24 spicymeatball kernel:         <Adaptec 29160 Ultra160 
SCSI adapter>
Oct 26 16:19:24 spicymeatball kernel:         aic7892: Ultra160 Wide 
Channel A, SCSI Id=7, 32/253 SCBs
Oct 26 16:19:24 spicymeatball kernel:
Oct 26 16:19:24 spicymeatball kernel: scsi1 : Adaptec AIC7XXX 
EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Oct 26 16:19:24 spicymeatball kernel:         <Adaptec 29160 Ultra160 
SCSI adapter>
Oct 26 16:19:24 spicymeatball kernel:         aic7892: Ultra160 Wide 
Channel A, SCSI Id=7, 32/253 SCBs
Oct 26 16:19:24 spicymeatball kernel:
Oct 26 16:19:24 spicymeatball kernel: blk: queue c1770e18, I/O limit 
4095Mb (mask 0xffffffff)
Oct 26 16:19:24 spicymeatball kernel: scsi0:0:6:0: Attempting to queue 
an ABORT message
Oct 26 16:19:24 spicymeatball kernel: scsi0: Dumping Card State in 
Command phase, at SEQADDR 0xbc
Oct 26 16:19:24 spicymeatball kernel: ACCUM = 0x80, SINDEX = 0xa0, 
DINDEX = 0xe4, ARG_2 = 0x0
Oct 26 16:19:24 spicymeatball kernel: HCNT = 0x0 SCBPTR = 0x0
Oct 26 16:19:24 spicymeatball kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Oct 26 16:19:24 spicymeatball kernel:  DFCNTRL = 0x4, DFSTATUS = 0x88
Oct 26 16:19:24 spicymeatball kernel: LASTPHASE = 0x80, SCSISIGI = 0x86, 
SXFRCTL0 = 0x88
Oct 26 16:19:24 spicymeatball kernel: SSTAT0 = 0x7, SSTAT1 = 0x1
Oct 26 16:19:24 spicymeatball kernel: SCSIPHASE = 0x10
Oct 26 16:19:24 spicymeatball kernel: STACK == 0x0, 0x0, 0x175, 0x34
Oct 26 16:19:24 spicymeatball kernel: SCB count = 4
Oct 26 16:19:24 spicymeatball kernel: Kernel NEXTQSCB = 2
Oct 26 16:19:24 spicymeatball kernel: Card NEXTQSCB = 0
Oct 26 16:19:24 spicymeatball kernel: QINFIFO entries:
Oct 26 16:19:24 spicymeatball kernel: Waiting Queue entries:
Oct 26 16:19:24 spicymeatball kernel: Disconnected Queue entries:
Oct 26 16:19:24 spicymeatball kernel: QOUTFIFO entries:
Oct 26 16:19:24 spicymeatball kernel: Sequencer Free SCB List: 1 2 3 4 5 
6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Oct 26 16:19:24 spicymeatball kernel: Sequencer SCB Info: 0(c 0x40, s 
0x67, l 0, t 0x3) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 
255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 
0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 
7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, 
s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 
0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, 
l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, 
t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xff, l 255, t 
0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 255, t 0xff) 
20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xff) 22(c 
0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(c 0x0, s 
0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, s 0xff, 
l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff, l 255, 
t 0xff) 29(c 0x0, s 0xff, l 255, t 0xf
Oct 26 16:19:24 spicymeatball kernel: ) 30(c 0x0, s 0xff, l 255, t 0xff) 
31(c 0x0, s 0xff, l 255, t 0xff)
Oct 26 16:19:24 spicymeatball kernel: Pending list: 3(c 0x40, s 0x67, l 0)
Oct 26 16:19:24 spicymeatball kernel: Kernel Free SCB list: 1 0
Oct 26 16:19:24 spicymeatball kernel: Untagged Q(6): 3
Oct 26 16:19:24 spicymeatball kernel: DevQ(0:6:0): 0 waiting
Oct 26 16:19:24 spicymeatball kernel: scsi0:0:6:0: Device is active, 
asserting ATN
Oct 26 16:19:24 spicymeatball kernel: Recovery code sleeping
Oct 26 16:19:24 spicymeatball kernel: Recovery code awake
Oct 26 16:19:24 spicymeatball kernel: Timer Expired
Oct 26 16:19:24 spicymeatball kernel: aic7xxx_abort returns 0x2003
Oct 26 16:19:24 spicymeatball kernel: scsi0:0:6:0: Attempting to queue a 
TARGET RESET message
Oct 26 16:19:24 spicymeatball kernel: aic7xxx_dev_reset returns 0x2003
Oct 26 16:19:24 spicymeatball kernel: Recovery SCB completes
Oct 26 16:19:24 spicymeatball kernel: scsi0:0:6:0: Attempting to queue 
an ABORT message
Oct 26 16:19:24 spicymeatball kernel: scsi0: Dumping Card State in 
Command phase, at SEQADDR 0x36
Oct 26 16:19:24 spicymeatball kernel: ACCUM = 0x80, SINDEX = 0xa0, 
DINDEX = 0xe4, ARG_2 = 0x0
Oct 26 16:19:24 spicymeatball kernel: HCNT = 0x0 SCBPTR = 0x0
Oct 26 16:19:24 spicymeatball kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Oct 26 16:19:24 spicymeatball kernel:  DFCNTRL = 0x4, DFSTATUS = 0x88
Oct 26 16:19:24 spicymeatball kernel: LASTPHASE = 0x80, SCSISIGI = 0x86, 
SXFRCTL0 = 0x88
Oct 26 16:19:24 spicymeatball kernel: SSTAT0 = 0x7, SSTAT1 = 0x1
Oct 26 16:19:24 spicymeatball kernel: SCSIPHASE = 0x10
Oct 26 16:19:24 spicymeatball kernel: STACK == 0x0, 0x0, 0x175, 0x34
Oct 26 16:19:24 spicymeatball kernel: SCB count = 4
Oct 26 16:19:24 spicymeatball kernel: Kernel NEXTQSCB = 3
Oct 26 16:19:24 spicymeatball kernel: Card NEXTQSCB = 0
Oct 26 16:19:24 spicymeatball kernel: QINFIFO entries:
Oct 26 16:19:24 spicymeatball kernel: Waiting Queue entries:
Oct 26 16:19:24 spicymeatball kernel: Disconnected Queue entries:
Oct 26 16:19:24 spicymeatball kernel: QOUTFIFO entries:
...
this continues for quite a few cycles until:
Oct 26 16:19:25 spicymeatball kernel: scsi: device set offline - not 
ready or command retry failed after bus reset: host 0 channel 0 id 8 lun 0
And the system finally boots (without the second card available of 
course).  As I said earlier, using a 2940UW as the second card works, 
but is unacceptable for this setup. Any ideas here?  I'm baffled.
Please cc me any replies, as I don't subscribe to the list.
thanks,

Ethan Weinstein


