Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263126AbTCLKAh>; Wed, 12 Mar 2003 05:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263128AbTCLKAh>; Wed, 12 Mar 2003 05:00:37 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:37044 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S263126AbTCLKAf>; Wed, 12 Mar 2003 05:00:35 -0500
Date: Wed, 12 Mar 2003 11:11:16 +0100
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is irq smp affinity good for anything?
Message-ID: <20030312101116.GB12206@pusa.informat.uv.es>
References: <20030311140458.GA15465@pusa.informat.uv.es> <Pine.LNX.4.44.0303112047240.15753-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0303112047240.15753-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 08:48:59PM -0500, Mark Hahn wrote:
> > I did not expect to increase global latency to these results...
> > and neither to increase latency in the CPU that's receiving 
> > just one interrupt!
> 
> but isn't that just a cache effect?  that is, you're keeping 
> all cpus busy (caches too) with user-space, so when the interrupt
> comes in, a bound interrupt has no choice, even if the cache 
> is busy with userspace.
Hi

first of all thanks for your reply, 

I think that user space code always has to make the best use of cache as it
can... in other words, i don't want to use a cpu exclusively for a device
that delivers 6000 ints/second

I bound an irq to a cpu because I thought that:

as spin_irq_locks just disables interrupts locally I should get better
latency that just one ISR on that particular cpu could at least reduce
a little the number of times that interrupts get disabled on that cpu

... that was my reasoning...

but latency gets worse... that's not comphrensible for me...

	Ulisses


                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
