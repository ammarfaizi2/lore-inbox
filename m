Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292515AbSBTVT6>; Wed, 20 Feb 2002 16:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292516AbSBTVTs>; Wed, 20 Feb 2002 16:19:48 -0500
Received: from f16.pav2.hotmail.com ([64.4.37.16]:12045 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S292515AbSBTVTn>;
	Wed, 20 Feb 2002 16:19:43 -0500
X-Originating-IP: [152.3.50.179]
From: "Bai Ao" <aobai@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: question about interrupt
Date: Wed, 20 Feb 2002 21:19:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F16cMzfoV1qdiixjnzi00010353@hotmail.com>
X-OriginalArrivalTime: 20 Feb 2002 21:19:37.0882 (UTC) FILETIME=[4D3B0FA0:01C1BA54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am really a linux kernel newbie here so please forgive me if I ask 
naive questions:

We have three linux machine which identical hardware setup.

AMD Athlon(tm) Processor 1G, 1.5G mem
VT82C693A/694 Host bridge
PCI bridge: VT82C598/694x [Apollo MVP3/Pro133x AGP]
SCSI storage controller: Adaptec 7892B
....

when I running redhat7.2's 2.4.9-21, everything is alright. (except kswapd 
takeoff lots of cpu time).
/proc/interupt
           CPU0
  0:   17286747          XT-PIC  timer
  1:      67209          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:    1373600          XT-PIC  serial
  4:     413973          XT-PIC  serial
  5:         29          XT-PIC  aic7xxx
  6:         39          XT-PIC  floppy
  8:   26939437          XT-PIC  rtc
  9:     266529          XT-PIC  es1371
10:   15518557          XT-PIC  eth0
11:     298020          XT-PIC  aic7xxx
12:    1372935          XT-PIC  PS/2 Mouse
14:      72784          XT-PIC  ide0
NMI:          0
ERR:          0

But if I compile 2.4.17(18) kernels, I will have such thing in dmesg:
spurious 8259A interrupt: IRQ7.
then /proc/interrupt:
           CPU0
  0:    1325588          XT-PIC  timer
  1:       6993          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     166173          XT-PIC  aic7xxx, es1371, usb-uhci, usb-uhci
  8:          1          XT-PIC  rtc
10:     371872          XT-PIC  eth0
12:     155683          XT-PIC  PS/2 Mouse
14:          2          XT-PIC  ide0
NMI:          0
LOC:    1325586
ERR:        208
MIS:          0

These machines running 2.4.17(18) series behave wierd recently, like 
x-windows crashing or font problem. Do these ERR numbers in /proc/interupt 
counts for this? What does these numbers mean and is that a bad thing? Thank 
you very much!

_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

