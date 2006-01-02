Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWABNm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWABNm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWABNm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:42:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20230 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750723AbWABNm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:42:27 -0500
Date: Mon, 2 Jan 2006 14:42:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102134228.GC17398@stusta.de>
References: <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org> <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102103721.GA8701@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 11:37:21AM +0100, Ingo Molnar wrote:
>...
> to say it loud and clear again: our current way of handling inlines is 
> _FUNDAMENTALLY BROKEN_. To me this means that fundamental changes are 
> needed for the _mechanics_ and meaning of inlines. We default to 'always 
> inline' which has a current information to noise ratio of 1:10 perhaps.  
> My patch changes the mechanics and meaning of inlines, and pretty much 
> anything else but a change to the meaning of inlines will still result 
> in the same scenario occuring over and over again.

Let's emphasize what we both agree on:
It is _FUNDAMENTALLY BROKEN_ that too much code is marked as
'always inline'.

We only disagree on how to achieve an improvement.

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

