Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSGARvR>; Mon, 1 Jul 2002 13:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSGARvR>; Mon, 1 Jul 2002 13:51:17 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55311 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316089AbSGARvP>; Mon, 1 Jul 2002 13:51:15 -0400
Date: Mon, 1 Jul 2002 13:48:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OKS] Module removal
Message-ID: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having read some notes on the Ottawa Kernel Summit, I'd like to offer some
comments on points raied.

The suggestion was made that kernel module removal be depreciated or
removed. I'd like to note that there are two common uses for this
capability, and the problems addressed by module removal should be kept in
mind. These are in addition to the PCMCIA issue raised.

1 - conversion between IDE-CD and IDE-SCSI. Some applications just work
better (or usefully at all) with one or the other driver used to read CDs.
I've noted that several programs for reading the image from an ISO CD
(readcd and sdd) have end of data problems with the SCSI interface.

2 - restarting NICs when total reinitialization is needed. In server
applications it's sometimes necessary to move or clear a NIC connection,
force renegotiation because the blade on the switch was set wrong, etc.
It's preferable to take down one NIC for a moment than suffer a full
outage via reboot.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

