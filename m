Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130031AbRBOVCd>; Thu, 15 Feb 2001 16:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbRBOVCX>; Thu, 15 Feb 2001 16:02:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8970 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130159AbRBOVCN>; Thu, 15 Feb 2001 16:02:13 -0500
Subject: Re: MTU and 2.4.x kernel
To: kuznet@ms2.inr.ac.ru
Date: Thu, 15 Feb 2001 21:01:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), roger@kea.GRace.CRi.NZ,
        linux-kernel@vger.kernel.org
In-Reply-To: <200102152041.XAA21220@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Feb 15, 2001 11:41:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TVWn-0000vQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I ran DNS reliably over AX.25 networks. They have an MTU of 216. They work.
> 
> 512 is maximal message size, which is transmitted without troubles,
> hardwired to almost all the datagram protocols.

Message size != MTU. DNS doesnt use DF. In fact DNS can even fall back to
TCP.

> > > B. Accoutning, classification, resource reervation does not work on
> > >    fragmented packets.
> > Thats a bug in accounting classification and resource reservation.
> Sorry? It is bug in client mtu selection. Functions above are impossible
> on fragmented packet even in theory. And because of A, if client uses mtu
> 296, it cannot use 100% of emerging and existing IP functions.

Tragic. You are required to accept existing realities and degrade nicely.

> > Over a 9600 mobile phone link mtu 296 makes measurable differences to the
> > latency when mixing a mail fetch with typing.
> 
> It is myth. Changing mtu until ~4K does not affect latency, it stays on 4K/bw.

Please tell that to my phone.

> >						 Over a radio link where 
> > error rate causes exponential increases in probability of packet loss as
> 
> Another myth. All they do error correction and have so high latency,
> that _increasing_ mtu only helps. And helps a lot.

No. There is large amounts of real world hardware that this is not true for. 
You cannot do good FEC on a narrow band link. 

Alan

