Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279755AbRJ3KyX>; Tue, 30 Oct 2001 05:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279912AbRJ3KyN>; Tue, 30 Oct 2001 05:54:13 -0500
Received: from [193.193.172.61] ([193.193.172.61]:50443 "EHLO
	mail8.GRUPPOCREDIT.IT") by vger.kernel.org with ESMTP
	id <S279755AbRJ3KyC>; Tue, 30 Oct 2001 05:54:02 -0500
Message-ID: <E504453C04C1D311988D00508B2C5C2D01D813D9@mail11.gruppocredit.it>
From: "Chemolli Francesco (USI)" <ChemolliF@GruppoCredit.it>
To: "'Laurent Deniel'" <deniel@worldnet.fr>, linux-kernel@vger.kernel.org
Subject: RE: Ethernet NIC dual homing
Date: Tue, 30 Oct 2001 12:05:17 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> Does someone know if there is some work in the area of NIC 
> dual homing ?
> By NIC dual homing, I mean two network devices (e.g. 
> Ethernet) that are
> connected to the same IP subnet but only one is active (at IP 
> level) at a 
> time.
[...]

Intel eepro100 cards, using Intel drivers (e100) and the ANS subsystem
(all available from Intel for free - as in beer) allow this
at the kernel-level, using link-detection to determine whether
to fail over.
They allow for failover, dual-active (only when sending) and Fast
EtherChannel.


Generally speaking, it shouldn't be hard to do it.
A shell script would be inefficient computation-wise, but should be simple
and
quite reliable: arping your default gateway and if it fails more than
X times ifconfig down; ifconfig up.

-- 
	/kinkie 
