Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbTDLGvs (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 02:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTDLGvs (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 02:51:48 -0400
Received: from mail017.syd.optusnet.com.au ([210.49.20.175]:62904 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263177AbTDLGvr (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 02:51:47 -0400
Message-Id: <4.3.1.2.20030412164450.02817b10@mail>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Sat, 12 Apr 2003 17:03:28 +1000
To: linux-kernel@vger.kernel.org
From: Troy Rollo <linux@troy.rollo.name>
Subject: Re: DMA Timeouts with 3112 SATA Controller (status == 0x21)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Me too" - when I enable DMA it's not long before the system stops 
responding altogether. Without DMA, I get a data read rate of about 800KBps.

But also, I have two identical drives attached - hda and hde (both 
ST380023AS). Even if I don't turn on DMA, if I am using both fairly 
intensively at the same time (at least that's the only thing I can identify 
as an apparent common difference), one will (on random occasions) start 
returning errors for every access. If this happens to be the drive that the 
operating system is installed on, the result is somewhat fatal. If it's the 
other drive I can continue, but any attempt to access it fails. There are 
some syslog entries that appear to relate to this:

Apr 11 07:42:49 milat kernel: hde: status timeout: status=0xd0 { Busy }
Apr 11 07:42:49 milat kernel:
Apr 11 07:42:49 milat kernel: ide2: reset phy, status=0x00000113, siimage_reset
Apr 11 07:42:49 milat kernel: hde: no DRQ after issuing WRITE
Apr 11 07:43:19 milat kernel: ide2: reset timed-out, status=0xd8
Apr 11 07:43:20 milat kernel: hde: status timeout: status=0xd8 { Busy }
Apr 11 07:43:20 milat kernel:
Apr 11 07:43:20 milat kernel: ide2: reset phy, status=0x00000113, siimage_reset
Apr 11 07:43:20 milat kernel: hde: drive not ready for command
Apr 11 07:43:51 milat kernel: t: I/O error, dev 21:02 (hde), sector 6183724
Apr 11 07:43:51 milat kernel: end_request: I/O error, dev 21:02 (hde), 
sector 6183726
Apr 11 07:43:51 milat kernel: end_request: I/O error, dev 21:02 (hde), 
sector 6183728
Apr 11 07:43:51 milat kernel: end_request: I/O error, dev 21:02 (hde), 
sector 6183730
Apr 11 07:43:51 milat kernel: end_request: I/O error, dev 21:02 (hde), 
sector 6183732
...

