Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287188AbRL2My6>; Sat, 29 Dec 2001 07:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287193AbRL2Myu>; Sat, 29 Dec 2001 07:54:50 -0500
Received: from colorfullife.com ([216.156.138.34]:15879 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287188AbRL2Myh>;
	Sat, 29 Dec 2001 07:54:37 -0500
Message-ID: <000701c1905a$08153af0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Daniel Stodden" <stodden@in.tum.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: NETIF_F_(SG|FRAGLIST|HIGHDMA) docs anywhere?
Date: Sat, 29 Dec 2001 12:14:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my major problem is test cases and getting the picture behind these
> structures.

Check skb_copy_and_csum_dev, used by the 8139too and via-rhine
network drivers: that's a software-only implementation of the NETIF_F_
flags.

Note that the kernel never uses scatter-gather without hardware
checksumming: concurrent sendfile()+write() would create packets
with invalid checksums.

--
    Manfred


