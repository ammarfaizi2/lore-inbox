Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbSAPRiQ>; Wed, 16 Jan 2002 12:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSAPRiH>; Wed, 16 Jan 2002 12:38:07 -0500
Received: from amdext.amd.com ([139.95.251.1]:17588 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S285347AbSAPRh6>;
	Wed, 16 Jan 2002 12:37:58 -0500
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <3C45B97C.9F7466B5@cmdmail.amd.com>
Date: Wed, 16 Jan 2002 09:33:48 -0800
From: "Amit Gupta" <amit.gupta@amd.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.5.1 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Luigi Genoni" <kernel@Expansa.sns.it>
cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Amit Gupta" <amit.gupta@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: arpd not working in 2.4.17 or 2.5.1
In-Reply-To: <Pine.LNX.4.44.0201161246490.31902-100000@Expansa.sns.it>
X-WSS-ID: 105B66F7438960-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We do have more than 1024 systems dircetly connected using switches.. and I am
working on getting a "lsf linux server master", which requires to open connections
all the machines in almost every second or so. Everthing works fine but as soon as
the master daemon tries to connect to systems >1024.. arp kills it with

Jan 15 08:54:08 lx-master kernel: NET: 464 messages suppressed.
Jan 15 08:54:08 lx-master kernel: Neighbour table overflow.
Jan 15 08:54:08 lx-master last message repeated 9 times
Jan 15 08:54:54 lx-master kernel: NET: 442 messages suppressed.
Jan 15 08:54:54 lx-master kernel: Neighbour table overflow.
Jan 15 08:54:54 lx-master last message repeated 8 times
Jan 15 08:56:24 lx-master kernel: NET: 443 messages suppressed.
Jan 15 08:56:24 lx-master kernel: Neighbour table overflow.

-Amit

Luigi Genoni wrote:

> On Tue, 15 Jan 2002, Alan Cox wrote:
>
> > > But arp>1024 is Very Important, else linux will never be able to talk to more
> > > than 1024 clients !
> > >
> > > Linux is my favourite and I wonder if this limit will kill linux for the race
> > > with Solaris/M$ server market. So pls save me :) and help neighour.c/network
> > > layer in new kernel.
> >
> > ARP applies for local links only. So you need a network you are actively
> > talking to 1024 different hosts directly on. Furthermore all the
> > config items should now be soft anyway. Want more, enable more.
>
> To have this kind of network is not impossible at all, I received mail
> from people at intel who are dealing with around 5000 arp (they say).
> In this situation with arpd there was no sensible performance loss, right
> now there is a big slowdown.


