Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTDUVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbTDUVyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:54:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16644 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262426AbTDUVyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:54:15 -0400
Date: Mon, 21 Apr 2003 15:05:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Runtime memory barrier patching
In-Reply-To: <3EA4660A.6000506@redhat.com>
Message-ID: <Pine.LNX.4.44.0304211502300.17938-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003, Ulrich Drepper wrote:

> Linus Torvalds wrote:
> 
> > They may _work_ for intel, but quite frankly they suck for most Intel (and 
> > probably non-intel too) CPU's. Using prefixes tends to almost always mess 
> > up the instruction decoders on most CPU's out there.
> 
> Indeed, using prefixes is terrible.

I would not be surprised if both AMD and Intel are playing some 
"benchmarking games" by trying to select nop's that work badly for the 
other side, and then showing how _their_ new CPU's are so much better by 
having the compilers emit the "preferred" no-ops.

But maybe I'm just too cynical. And I do suspect the Hammer optimization
guide was meant for the 64-bit mode only, because I'm pretty certain even
AMD does badly on prefixes at least in older CPU generations.

		Linus

