Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbRHWO7G>; Thu, 23 Aug 2001 10:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268133AbRHWO65>; Thu, 23 Aug 2001 10:58:57 -0400
Received: from relay03.cablecom.net ([62.2.33.103]:54289 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S267997AbRHWO6q>; Thu, 23 Aug 2001 10:58:46 -0400
Message-Id: <200108231458.f7NEwqk24604@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: hardware checksumming
Date: Thu, 23 Aug 2001 16:58:48 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.10.10108231354000.6061-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10108231354000.6061-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oh its me again. sorry but the message bofore was messed up. so lets try 
again.

On Thursday 23 August 2001 15:54, you wrote:
> > is hardware support by a NIC for checksum generation / offloading not
> > quite usless? the checksumming enging can only be used when UDP/TCP
> > packets are <= the MTU of the NIC (e.g 1500 bytes).
>
> checksums can be chained.
yes that might be easy for the NIC's transmitting enging when all fragments 
belonging together come one after the other in the transmit-ring. 
but receiving is difficult since different connections can arrive 
simultanously and reslut in interleaved framgents.

something else: you need quite a lot of ram on the NIC to buffer fragments.
if not it will have to transfer the data twice through the PCI (checksumm are 
at the beginig of a packet not the end). nobody did spend a second on 
thinking to implement all in hardware when the interet protokol was desinged.

do you know any NIC that is capable of chaining? currenty i've a dp83820
on my desc and at the moment im not eaven shure if checksumming can
be chained over multiple descriptions (describing one single ethernet frame).

>
> > i expact that UDP/TCP packets are in general bigger than that or is
> > exactly
>
> TCP packets are certainly never larger than the MTU.

