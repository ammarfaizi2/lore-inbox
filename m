Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318238AbSGYFLI>; Thu, 25 Jul 2002 01:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318319AbSGYFLI>; Thu, 25 Jul 2002 01:11:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5906 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318238AbSGYFLI>; Thu, 25 Jul 2002 01:11:08 -0400
Date: Wed, 24 Jul 2002 22:15:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Alexander Viro <viro@math.psu.edu>, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.28 and partitions
In-Reply-To: <5.1.0.14.2.20020725030051.02114cb0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0207242213540.1231-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Jul 2002, Anton Altaparmakov wrote:
>
> >u64 for sector_t doesn't change anything for 64bit boxen that might be
> >interested in really large disks and screws 32bit ones that shouldn't
> >have to pay for that...
>
> True. That's why sector_t should be a compile time option in the kernel
> "Enable large device support > 2TiB:  Y/N". Then I am happy and loads of
> other people because we can use large raid arrays without having to buy the
> latest expensive system and other people are happy for having faster 32-bit
> code... Surely we can write robust enough code which will work with either
> sector_t size...

Careful. One issue is user-level interfaces to the kernel. I would suggest
any user level interface should use u64, not "sector_t". So that there is
zero confusion. Clearly 64-bit sector numbers will be/are really close to
being an issue for some people.

		Linus

