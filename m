Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317572AbSGOSYL>; Mon, 15 Jul 2002 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSGOSYK>; Mon, 15 Jul 2002 14:24:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11023 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317572AbSGOSYK>; Mon, 15 Jul 2002 14:24:10 -0400
Date: Mon, 15 Jul 2002 11:23:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@suse.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
In-Reply-To: <20020715184559.C32582@suse.de>
Message-ID: <Pine.LNX.4.33.0207151119580.19586-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Jul 2002, Dave Jones wrote:
> 
> the .o files get linked into agpgart.o
> Still just one module. Christoph Hellwig proposed making each back
> end a module too, which is dependant upon agpgart.o, but that's more
> pain than I feel like enduring right now.. Maybe later.
> 
> Linus ?

I'm perfectly happy with something like "via-agp.c", if it heads off 
potential future trouble. I just don't like the "agpgart_be" thing, it's 
unreadable in the first place, too long in the second, and having a prefix 
(as opposed to a postfix) makes filename completion suck in the third 
place.

Something like "via-agp.c" doesn't have any of those problems, and while
the "agp" is slightly redundant in the directory structure, it's at least
not ugly.

		Linus

