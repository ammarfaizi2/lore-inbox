Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266173AbSKFWaW>; Wed, 6 Nov 2002 17:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSKFWaV>; Wed, 6 Nov 2002 17:30:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53510 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266173AbSKFWaU>; Wed, 6 Nov 2002 17:30:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Voyager subarchitecture for 2.5.46
Date: 6 Nov 2002 14:36:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aqc5hg$ugp$1@cesium.transmeta.com>
References: <200211061503.gA6F3DW02053@localhost.localdomain> <Pine.LNX.4.44.0211060729210.2393-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0211060729210.2393-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> I disagree.
> 
> We should use the TSC everywhere (if it exists, of course), and the fact
> that two CPU's don't run synchronized shouldn't matter.
> 

If it exists, and works :-/

> It's clearly stupid in the long run to depend on the TSC synchronization.
> We should consider different CPU's to be different clock-domains, and just
> synchronize them using the primitives we already have (hey, people can use
> ntp to synchronize over networks quite well, and that's without the kind
> of synchronization primitives that we have within the same box).

Synchronizing them is nice, since it makes RDTSC usable in user
space (without nodelocking.)  If it ain't doable, then it ain't.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
