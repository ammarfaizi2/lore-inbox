Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132030AbRAaTMq>; Wed, 31 Jan 2001 14:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132063AbRAaTMg>; Wed, 31 Jan 2001 14:12:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46601 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132030AbRAaTMa>; Wed, 31 Jan 2001 14:12:30 -0500
Subject: Re: Kernel 2.2.18: Protocol 0008 is buggy
To: lists@cyclades.com (Ivan Passos)
Date: Wed, 31 Jan 2001 19:12:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.10.10101310739150.3420-100000@main.cyclades.com> from "Ivan Passos" at Jan 31, 2001 07:43:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O2gV-0002vT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this really supposed to be done in the HW driver / support code level,
> or is it supposed to be done in the protocol (IP / ARP) level??

oops I was half asleep

Driver sets

	skb->mac.raw
	skb->pkt_type
	skb->protocol
(see net/ethernet/eth.c)

	skb->h.raw and skb->nh.raw are set by the receive action code

On transmit

	nh.raw is set by the protocol
	

Note that non -ac kernels have a bug where a packet consisting of pure mac
header causes bogus warnings

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
