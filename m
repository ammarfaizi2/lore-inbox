Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbTBRBzF>; Mon, 17 Feb 2003 20:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbTBRBzF>; Mon, 17 Feb 2003 20:55:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39953 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267510AbTBRBzE>; Mon, 17 Feb 2003 20:55:04 -0500
Date: Mon, 17 Feb 2003 18:02:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
In-Reply-To: <20030218015353.GA7844@f00f.org>
Message-ID: <Pine.LNX.4.44.0302171752560.1754-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Feb 2003, Chris Wedgwood wrote:
> 
>   plain 2.5.59 does
> 
>   59-mjb4 does NOT

Can you check mjb 1-3 too? The better it gets pinpointed, the easier it's 
going to be to find.

Also, if you can figure out _which_ part of the patch makes a difference,
that would obviously be even better.  Part of the stuff in mjb is already
merged in later kernels (ie things like using sequence locks for xtime is
already there in 2.5.60, so clearly that doesn't seem to be the thing that
helps your situation).

Martin cc'd, in case he has suggestions on how/what to split up the patch.

Do you use the starfire driver? That's a big part of the patch, for
example.. And part of the patch just makes the timer interrupt happen much
less often, if you havn't configured for 1000Hz - and it may well be that
small perturbations like that are the things that matter to you.

		Linus

