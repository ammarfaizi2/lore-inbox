Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267992AbRG3VNR>; Mon, 30 Jul 2001 17:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268003AbRG3VM6>; Mon, 30 Jul 2001 17:12:58 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:59889 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267992AbRG3VMi>; Mon, 30 Jul 2001 17:12:38 -0400
Message-ID: <3B65CDC8.7ECE387A@yahoo.co.uk>
Date: Mon, 30 Jul 2001 17:12:40 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "serial" does not show up in /proc/interrupts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I am looking for the cause of an oops (more info
to come in another message) and I noticed the following
anomaly.  I am using a modular serial driver on /dev/ttyS0
and /dev/ttyS1 (actually /dev/tts/0 and /dev/tts/1 under
devfs).  See the listing of my /proc/interrupts below.
I am not using /dev/ttyS0 at the moment, so IRQ4 isn't listed
as used.  I assume that's normal.  But I do have /dev/ttyS1
open; it uses IRQ3.  But note that the name of the serial
driver is not printed in the list.  Why not?

root@thanatos:~# cat /proc/interrupts
           CPU0       
  0:      65078          XT-PIC  timer
  1:       1546          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       1979          XT-PIC  
  5:       3324          XT-PIC  CS4231
  7:          4          XT-PIC  parport0
  8:          1          XT-PIC  rtc
 10:         27          XT-PIC  mwave_3780i
 11:       5021          XT-PIC  usb-uhci, Texas Instruments PCI1250, Texas Instruments PCI1250 (#2)
 12:       3268          XT-PIC  PS/2 Mouse
 14:       8807          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0 
ERR:          0

Fishy!

--
Thomas Hood
jdthood_AT_yahoo.co.uk
