Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287781AbSBMQpi>; Wed, 13 Feb 2002 11:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287794AbSBMQp2>; Wed, 13 Feb 2002 11:45:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1804 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287781AbSBMQpO>; Wed, 13 Feb 2002 11:45:14 -0500
Date: Wed, 13 Feb 2002 10:30:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <3C6A5D79.33C31910@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202131028130.13632-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Feb 2002, Jeff Garzik wrote:
>
> These changes are wrong.  The addresses desired need to be obtained from
> the pci_alloc_consistent return values.

Let's face it, people won't care about the complex PCI interfaces unless
they give you something useful.

On most PC's, they don't.

In short, don't expect driver writers to care about somethign that simply
doesn't matter to them. Rant and rail all you want, but I think the thing
needs to be simplified to be acceptable to people. Many of these things
basically exists only on PC's, and are done on 1:1 pages (ie GFP_KERNEL),
so "virt_to_phys()" works.

Basic rule: it's up to _other_ architectures to fix drivers that don't
work for them. Always has been. Because there's no way you can get the
people who just want to have something working to care.

		Linus

