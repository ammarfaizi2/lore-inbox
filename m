Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129994AbRAGSzC>; Sun, 7 Jan 2001 13:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131784AbRAGSyw>; Sun, 7 Jan 2001 13:54:52 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:44708 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S131124AbRAGSyr>;
	Sun, 7 Jan 2001 13:54:47 -0500
Date: Sun, 7 Jan 2001 13:53:48 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <3A58C57A.131BFEF2@candelatech.com>
Message-ID: <Pine.GSO.4.30.0101071344020.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Ben Greear wrote:
> jamal wrote:
> >
> > erm, this is a MUST. You MUST factor the hardware VLANs and be totaly
> > 802.1q compliant. Also of interest is 802.1P and D. We must have full
> > compliance, not some toy emulation.
>
> I have seen neither hardware nor spec sheets on how these NICs are doing
> VLAN 'support'.  So, I don't know what the best way to support them is.
>

Most of the GIGe interfaces do provide VLAN insertion/removal. You
pass/receive it as part of the DMA descriptor.

> If it requires driver changes, then the ethernet driver folks will need
> to be involved.
>

I think the design MUST consider not just a poor man's VLAN way of
doing things. You and the other VLAN folks (Gleb and co) will have to iron
that out. Basically, all i am saying is that if there is going to be a
linux solution at some point, the requirement for these devices is a MUST.
Please involve me in discussions you guys end up having.

> There is also a difference between supporting hardware VLAN solutions
> and being 100% compliant:  If I can send/receive packets that are
> 100% compliant from an RTL 8139 NIC, then as far as the world (ie Switch) knows,
> I am 100% compliant.
>

ok.

> If the specific VLAN hardware features are not supported in some exotic
> NIC, then that should just mean slightly less performance, or worst cast,
> not supporting that particular NIC.

The included design must be flexible enough to allow for this. As much as
i hate it, some vendors will continue releasing binaries only for their
code.

>
> My vlan code supports setting of Priority bits already (thats' the .1P, right?)
>

right. There's a lot of work to be done in that area.

> What is the .1D stuff about?
>

spanning tree. Seems the bridging code already does this.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
