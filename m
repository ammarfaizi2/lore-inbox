Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRHWOqb>; Thu, 23 Aug 2001 10:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbRHWOqV>; Thu, 23 Aug 2001 10:46:21 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:33298 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S267534AbRHWOqK>; Thu, 23 Aug 2001 10:46:10 -0400
Message-Id: <200108231446.f7NEkMk29499@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: hardware checksumming
Date: Thu, 23 Aug 2001 16:46:15 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.10.10108231354000.6061-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10108231354000.6061-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 August 2001 15:54, you wrote:
> > is hardware support by a NIC for checksum generation / offloading not
> > quite usless? the checksumming enging can only be used when UDP/TCP
> > packets are <= the MTU of the NIC (e.g 1500 bytes).
>
> checksums can be chained.
yes that might be easy fores belonging together come one after the other. so 
the NIC ha transmit, since all chained frams only to trak one 
fragmentet packet. but receiving is will become difficult since different
conections can arrive interleaved. something else: the NIC needs quite
a lot of ram or huge fifios. if not it will have to transfer the data twice 
through the PCI (checksumm are at the beginig of a packet not the
end). nobody did spend a second on thinking to implement all in hard-
ware when the interet protokol was desinged.

do you know any NIC that is capable of chaining? currenty i've a dp83820
on my desc and at the moment im not eaven shure if checksumming can
be chained over multiple descriptions (describing one single ethernet frame).

>
> > i expact that UDP/TCP packets are in general bigger than that or is
> > exactly
>
> TCP packets are certainly never larger than the MTU.
