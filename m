Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268483AbRGXVrI>; Tue, 24 Jul 2001 17:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268481AbRGXVrD>; Tue, 24 Jul 2001 17:47:03 -0400
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:43532 "EHLO
	mail.applianceware.com") by vger.kernel.org with ESMTP
	id <S268483AbRGXVqu>; Tue, 24 Jul 2001 17:46:50 -0400
Message-ID: <3B5DECD6.B4351288@applianceware.com>
Date: Tue, 24 Jul 2001 14:47:02 -0700
From: Craig Spurgeon <cspurgeon@applianceware.com>
Reply-To: cspurgeon@applianceware.com
Organization: ApplianceWare
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NatSemi DP83820 driver problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

We have an Asante GigaNIX 1000T Gigabit Ethernet adapter that we are
trying to get to work under kernel 2.4.6ac5.

National supplied their driver for the chip to Asante, and Asante
sent it to us. It would not compile as shipped, due to a reference
to skb->dataref.

I contacted Asante tech support and National tech support, no
response from either.

So I changed the skb->dataref to the counter field at the end
of skb_shared_info and it compiled.

I installed it and the adapter worked, but it came up at 100Mbit
and half-duplex. The default according to the source code is
1000Mbit full-duplex.

No parameters were supplied on the module load line.

Does anyone have any experience getting this driver to come up
successfully under 2.4.x?

Also, I emailed Donald Becker at Scyld, he told me to use the ns820.c
file in the scyld.com ftp site which was in the test directory.

He said that version should work under 2.4, and he was working on
transceiver issues still.

That driver was missing the new task code used for notifying higher-
level layers of the ability of the card to send data, so it won't
work.

I have emailed him asking for that change, however, we are leaning
in the direction of wanting to use the driver from National.

If anyone has gotten the Scyld driver to work under 2.4.x, we'd
really appreciate the info.

TIA

-Craig Spurgeon
-- 

-----------------------------------------------------------------------------
Craig Spurgeon, Linux Architect        |  Microsoft Innovations List
ApplianceWare, Inc.                    |           (empty)
510-580-5148                           |
-----------------------------------------------------------------------------
