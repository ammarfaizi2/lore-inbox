Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbRCFAQX>; Mon, 5 Mar 2001 19:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130793AbRCFAQN>; Mon, 5 Mar 2001 19:16:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51717 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130792AbRCFAP6>; Mon, 5 Mar 2001 19:15:58 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kmalloc() alignment
Date: 5 Mar 2001 16:15:36 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <981a78$cb2$1@cesium.transmeta.com>
In-Reply-To: <3AA2C488.54A792AD@colorfullife.com> <20010306000652.A13992@excalibur.research.wombat.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010306000652.A13992@excalibur.research.wombat.ie>
By author:    Kenn Humborg <kenn@linux.ie>
In newsgroup: linux.dev.kernel
>
> On Sun, Mar 04, 2001 at 11:41:12PM +0100, Manfred Spraul wrote:
> > >
> > > Does kmalloc() make any guarantees of the alignment of allocated 
> > > blocks? Will the returned block always be 4-, 8- or 16-byte 
> > > aligned, for example? 
> > >
> > 
> > 4-byte alignment is guaranteed on 32-bit cpus, 8-byte alignment on
> > 64-bit cpus.
> 
> So, to summarise (for 32-bit CPUs):
> 
> o  Alan Cox & Manfred Spraul say 4-byte alignment is guaranteed.
> 
> o  If you need larger alignment, you need to alloc a larger space,
>    round as necessary, and keep the original pointer for kfree()
> 
> Maybe I'll just use get_free_pages, since it's a 64KB chunk that
> I need (and it's only a once-off).
> 

It might be worth asking the question if larger blocks are more
aligned?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
