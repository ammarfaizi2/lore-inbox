Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUEUShs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUEUShs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 14:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265933AbUEUShs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 14:37:48 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:29945 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265928AbUEUShp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 14:37:45 -0400
Message-ID: <003b01c43f62$b54724e0$0201a8c0@main>
From: "Darrell Blake" <darrell@dunmanifestin.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Possible USB bug in 2.6
Date: Fri, 21 May 2004 19:37:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-OriginalArrivalTime: 21 May 2004 18:37:48.0055 (UTC) FILETIME=[B6DDCA70:01C43F62]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I may have found a bug in the 2.6 kernel and am hoping someone 
can help me find what's causing the problem so it can be solved. 
Basically, I have a wireless keyboard and mouse which works via one USB 
connection (I can only assume it uses a hub) which work fine under 2.4 
but in 2.6 the mouse jerks. It doesn't move smoothly from point A to 
point B it jerks there. The mouse works fine in NetBSD too which is 
what's leading me to believe it's a bug in the 2.6 kernel.

I've tried multiple configurations and loading and unloading many 
different modules to try and find out if something is conflicting or 
what's causing it but can't find anything. I've also tried using non 
vanilla kernels such as Mandrake's, Red Hat's, Gentoo's and SuSE's but I 
still get the same problem.

This is the output from lsusb in 2.4...

Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 003 Device 002: ID 041e:3020 Creative Technology, Ltd
Bus 002 Device 001: ID 0000:0000
Bus 002 Device 002: ID 04b8:0005 Seiko Epson Corp. Stylus Printer
Bus 002 Device 004: ID 0419:0600 Samsung Info. Systems America, Inc.
Bus 001 Device 001: ID 0000:0000

...and this is the output from lsusb in 2.6...

Bus 004 Device 001: ID 0000:0000
Bus 003 Device 002: ID 041e:3020 Creative Technology, Ltd
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 004: ID 0419:0600 Samsung Info. Systems America, Inc.
Bus 002 Device 002: ID 04b8:0005 Seiko Epson Corp. Stylus Printer
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

I don't know which one of those it will be though. Although the keyboard 
and mouse are Creative Labs I'm assuming the Creative one showing is my 
sound card (SB Audigy2 NX) because that works fine. Epson is the printer 
obviously so it must be the Samsung thing. Strange considering it's made 
by Creative Labs.

Just another note. Under FreeBSD and NetBSD the devusb command shows it 
up as a wireless keyboard and mouse. I don't suppose this would make a 
difference though.

Darrell



