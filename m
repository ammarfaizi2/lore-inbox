Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281471AbRKHFaG>; Thu, 8 Nov 2001 00:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281425AbRKHF34>; Thu, 8 Nov 2001 00:29:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60686 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281261AbRKHF3o>; Thu, 8 Nov 2001 00:29:44 -0500
Date: Wed, 7 Nov 2001 21:26:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Krishna Kumar <kumarkr@us.ibm.com>
cc: Andreas Dilger <adilger@turbolabs.com>, <ak@muc.de>, <andrewm@uow.edu.au>,
        "David S. Miller" <davem@redhat.com>, <jgarzik@mandrakesoft.com>,
        <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, <owner-netdev@oss.sgi.com>,
        <tim@physik3.uni-rostock.de>
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
In-Reply-To: <OF80A3FFE5.FC1D4628-ON88256AFE.0010957E@boulder.ibm.com>
Message-ID: <Pine.LNX.4.33.0111072125020.1137-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Nov 2001, Krishna Kumar wrote:
> >
> > In short: It is wrong to do
> >
> >          if (jiffies <= start+HZ)
> >
> > and it is _right_ to do
> >
> >          if (jiffies - start <= HZ)
>
> Actually this last part is wrong, isn't it ? jiffies <= start + HZ is also
> a correct way to do it, since start+HZ will overflow to the current value
> of jiffies when HZ time elapses. So the above two statements are IDENTICAL.

No.

Try it out with a few examples. You'll see.

		Linus

