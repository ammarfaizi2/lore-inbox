Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270630AbRHXIDV>; Fri, 24 Aug 2001 04:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270948AbRHXIDN>; Fri, 24 Aug 2001 04:03:13 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:41732 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S270630AbRHXIDC>; Fri, 24 Aug 2001 04:03:02 -0400
Message-ID: <3B8609EF.789D99F5@idb.hist.no>
Date: Fri, 24 Aug 2001 10:01:51 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: cwidmer@iiic.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: hardware checksumming
In-Reply-To: <Pine.LNX.4.10.10108231354000.6061-100000@coffee.psychology.mcmaster.ca> <200108231458.f7NEwqk24604@mail.swissonline.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Widmer wrote:

> yes that might be easy for the NIC's transmitting enging when all fragments
> belonging together come one after the other in the transmit-ring.
> but receiving is difficult since different connections can arrive
> simultanously and reslut in interleaved framgents.
> 
> something else: you need quite a lot of ram on the NIC to buffer fragments.
> if not it will have to transfer the data twice through the PCI (checksumm are
> at the beginig of a packet not the end). nobody did spend a second on
> thinking to implement all in hardware when the interet protokol was desinged.

You don't have to store entire fragments in a NIC to do
hw checksums.  All you need to store is the partial checksums,
and add to them whenever yet another fragment comes in for
that packet.

Helge Hafting
