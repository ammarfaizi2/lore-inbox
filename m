Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266544AbUFVD2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUFVD2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 23:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUFVD2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 23:28:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:29850 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266544AbUFVD2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 23:28:33 -0400
Date: Mon, 21 Jun 2004 20:26:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>,
       Matt Porter <mporter@kernel.crashing.org>,
       Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
In-Reply-To: <Pine.LNX.4.58.0406212006270.6530@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0406212024550.6530@ppc970.osdl.org>
References: <20040618175902.778e616a.spyro@f2s.com> <20040618110721.B3851@home.com>
 <40D3356E.8040800@hp.com> <20040618122112.D3851@home.com>
 <20040618204322.C17516@flint.arm.linux.org.uk> <s5hoendm3td.wl@alsa2.suse.de>
 <20040622000838.B7802@flint.arm.linux.org.uk> <40D7941F.3020909@pobox.com>
 <Pine.LNX.4.58.0406212006270.6530@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jun 2004, Linus Torvalds wrote:
> 
> The argument at some point was that some architectures may not even _have_
> a "struct page" for DMA memory, since it's not "normal" memory (ie "slow
> memory" on m68k). However, I thought we all agreed that such a "struct
> page" could be furnished if that architecture wants so support mmap'ing.

.. which is not to say that we shouldn't have a "pci_mmap_pages()" thing
_too_. Pretty clearly the easiest interface often is to just map the pages
at mmap() time, and then we should just have a helper function to do that. 

I thought we did one already, but hey, maybe not.

		Linus
