Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271002AbTHKFU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271118AbTHKFU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:20:59 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37253 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271002AbTHKFU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:20:58 -0400
Date: Mon, 11 Aug 2003 06:20:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: James Morris <jmorris@intercode.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com, tytso@mit.edu
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030811052035.GK10446@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk> <20030811023553.GC31810@waste.org> <20030811045947.GI10446@mail.jlokier.co.uk> <20030811050414.GE31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811050414.GE31810@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Mon, Aug 11, 2003 at 05:59:47AM +0100, Jamie Lokier wrote:
> > Matt Mackall wrote:
> > > And we're safe here. The default pool size is 1024 bits, of which we
> > > hash 512. I could hash even fewer, say, 480 (and this would deal with the
> > > cryptoapi padding stuff nicely).
> > 
> > Where is the pool size set to 1024 bits?  I'm reading 2.5.75, and it
> > looks to me like the hash is over the whole pool, of 512 bits for the
> > primary and 128 bits for the secondary pool:
> > 
> > 	for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
>                                                ^^^^
> 
> Unfortunately, there's an ugly mix of words, bytes, and bits here (and it
> was actually broken for years because of it). The input pool is 4kbits
> and the output pools are 1k.

You're right about the sizes.  But you said it hashes only half of the
pool.  Where is that?

-- Jamie

