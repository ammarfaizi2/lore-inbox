Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129301AbQKGMWH>; Tue, 7 Nov 2000 07:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQKGMV6>; Tue, 7 Nov 2000 07:21:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11896 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129301AbQKGMVp>; Tue, 7 Nov 2000 07:21:45 -0500
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
To: jordy@napster.com (Jordan Mendelson)
Date: Tue, 7 Nov 2000 12:22:14 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
In-Reply-To: <3A07B01A.1E70EE20@napster.com> from "Jordan Mendelson" at Nov 06, 2000 11:32:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7lX-0007LD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Assuming this is true, it explains why Win98's TCP does not "see" the
> > data sent by Linux, because such a bug would make the TCP checksum of
> > these packets incorrect and thus dropped by Win98's TCP.
> 
> Ok, but why doesn't 2.2.16 exhibit this behavior?
> 
> We've had reports from quite a number of people complaining about this
> and I'm fairly certain not all of them are from Earthlink.

If their system is confused by tcp options in data segments then the SACK stuff
in 2.4 may well be the trigger. Windows generally doesnt try and use vj at
all. With the predictable QA results for anyone who does try and use it


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
