Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030577AbWFJAte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbWFJAte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbWFJAte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:49:34 -0400
Received: from mercury.sdinet.de ([193.103.161.30]:9880 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S1030575AbWFJAtd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:49:33 -0400
Date: Sat, 10 Jun 2006 02:49:32 +0200 (CEST)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Michael Poole <mdpoole@troilus.org>
cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
In-Reply-To: <87irnab33v.fsf@graviton.dyn.troilus.org>
Message-ID: <Pine.LNX.4.64.0606100245130.12765@mercury.sdinet.de>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org>
 <44899653.1020007@garzik.org> <87irnab33v.fsf@graviton.dyn.troilus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Michael Poole wrote:

> Jeff Garzik writes:
>
>> Andrew Morton wrote:
>>> Ted&co have been pretty good at avoiding compatibility problems.
>>
>> Well, extents and 48bit make that track record demonstrably worse.
>>
>> Users are now forced to remember that, if they write to their
>> filesystem after using either $mmver or $korgver kernels, they are
>> locked out of using older kernels.
>
> Users are also forced to remember that, if they use certain new
> distros or programs, they are locked out of using older kernels.  They
> are forced to remember that if they have certain newer hardware, they
> are locked out of using older kernels.  They are forced to remember
> that if they use ext3 (or XFS or JFS) _at all_ they are locked out of
> using older kernels.  Why single out this particular aspect of limited
> forward compatibility to harp on so much?

I see a different problem with "ext3 + extends is not ext3 anymore" when 
the feature goes mainstream:
- user with old distri, no extends in use, no kernel support for them
- user has some kind of problem
- uses new rescue disk (aka knoppix at the time of problem) - that then
   is current stuff, and certainly uses extents - fixes problem on disk
   (may be a simple as running lilo/grub from chroot, happens often for me)
- tries to boot back into his distri -> *boom* he lost

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
