Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268788AbRG0Gno>; Fri, 27 Jul 2001 02:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268787AbRG0Gne>; Fri, 27 Jul 2001 02:43:34 -0400
Received: from samar.sasken.com ([164.164.56.2]:9345 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S268788AbRG0GnZ> convert rfc822-to-8bit;
	Fri, 27 Jul 2001 02:43:25 -0400
Date: Fri, 27 Jul 2001 12:13:16 +0530 (IST)
From: Deepika Kakrania <deepika@sasken.com>
To: =?windows-1250?Q?Lubom=EDr_Bulej?= <pallas@kadan.cz>
cc: <linux-net@vger.rutgers.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: CBQ is not limiting bandwidth!!!
In-Reply-To: <Pine.LNX.4.33.0107261623540.2339-100000@ps.kadan.cz>
Message-ID: <Pine.GSO.4.30.0107271157410.14048-100000@sunk2.sasi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


 Thanks a lot for the reply. Now it's working fine. But I have another
problem.

 If I set all these rules with bandwith parameter set to 100Mbit, then
results are near to expected results. But when I set bandwidth parameter
to 10Mbit with all other parameters unchanged it doesn't give correct
results.

The results I got for both cases are following.

 BANDWITH	RATE 		WEIGHT		Throughput (as seen using
						 netperf)

 10 Mbit	4 Mbit	        400 Kbit		6.38 Mbps
 10 Mbit	5 Mbit		500 Kbit		7.31 Mbps

 100 Mbit	4 Mbit		400 Kbit		4.08 Mbps
 100 Mbit	5 Mbit		500 Kbit		5.11 Mbps.

Can anyone explain what could be the reason for this? Why I don't get
correct results when I set bandwidth to 10 Mbit?

Thanks in advance.

regards,
Deepika

On Thu, 26 Jul 2001, [windows-1250] Lubomír Bulej wrote:

> Hi,
>
> >   I am defining only one class at m/c router on interface eth1. The tc
> > rules set up for doing so are following.
> >
> >  tc qdisc add dev eth1 root handle 1: cbq bandwidth 10Mbit cell 8 avpkt
> > 1000 mpu 64
> >
> >  tc class add dev eth1 parent 1:0 classud 1:1 cbq bandwidth 10Mbit rate
> > 1kbit allot 1514 cell 8 weigth 100bit prio 5 maxburst 20 avpkt 1000
>
> Add "bounded" at the end of the command... Otherwise the class borrows
> bandwidth from its parent.
>
>
> Regards,
> Lubomir
>

