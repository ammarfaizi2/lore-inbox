Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136308AbRAGSfT>; Sun, 7 Jan 2001 13:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136339AbRAGSfJ>; Sun, 7 Jan 2001 13:35:09 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:54285 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S136308AbRAGSe4>;
	Sun, 7 Jan 2001 13:34:56 -0500
Message-ID: <3A58C57A.131BFEF2@candelatech.com>
Date: Sun, 07 Jan 2001 12:37:30 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <Pine.GSO.4.30.0101071317440.18916-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> On Sun, 7 Jan 2001, Ben Greear wrote:
> 
> > > Question: How do devices with hardware vlan support fit into your model ?
> >
> > I don't know of any, and I'm not sure how they would be supported.
> >
> 
> erm, this is a MUST. You MUST factor the hardware VLANs and be totaly
> 802.1q compliant. Also of interest is 802.1P and D. We must have full
> compliance, not some toy emulation.

I have seen neither hardware nor spec sheets on how these NICs are doing
VLAN 'support'.  So, I don't know what the best way to support them is.

If it requires driver changes, then the ethernet driver folks will need
to be involved.

There is also a difference between supporting hardware VLAN solutions
and being 100% compliant:  If I can send/receive packets that are
100% compliant from an RTL 8139 NIC, then as far as the world (ie Switch) knows,
I am 100% compliant.

If the specific VLAN hardware features are not supported in some exotic
NIC, then that should just mean slightly less performance, or worst cast,
not supporting that particular NIC.

My vlan code supports setting of Priority bits already (thats' the .1P, right?)

What is the .1D stuff about?

> 
> cheers,
> jamal

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
