Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVBBT7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVBBT7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVBBTq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:46:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22477 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262679AbVBBTkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:40:06 -0500
Date: Wed, 2 Feb 2005 14:31:10 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: A scrub daemon (prezeroing)
Message-ID: <20050202163110.GB23132@logos.cnet>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com> <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet> <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 11:05:14AM -0800, Christoph Lameter wrote:
> On Wed, 2 Feb 2005, Marcelo Tosatti wrote:
> 
> > Sounds very interesting idea to me. Guess it depends on whether the cost of
> > DMA write for memory zeroing, which is memory architecture/DMA engine dependant,
> > offsets the cost of CPU zeroing.
> >
> > Do you have any thoughts on that?
> >
> > I wonder if such thing (using unrelated devices DMA engine's for zeroing) ever been
> > done on other OS'es?
> >
> > AFAIK SGI's BTE is special purpose hardware for memory zeroing.
> 
> Nope the BTE is a block transfer engine. Its an inter numa node DMA thing
> that is being abused to zero blocks. 

Ah, OK. 
Is there a driver for normal BTE operation or is not kernel-controlled ?

> The same can be done with most DMA chips (I have done so on some other
> platforms not on i386)

Nice! What kind of DMA chip was that and through which kind of bus was it connected
to CPU ?

I wonder what has to be done to have active DMA engines be abused for zeroing
when idle and what are the implications of that. Some kind of notification mechanism 
is necessary to inform idleness ? 

Someone should try implementing the zeroing driver for a fast x86 PCI device. :)
