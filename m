Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSH3Xb0>; Fri, 30 Aug 2002 19:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSH3Xb0>; Fri, 30 Aug 2002 19:31:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30993 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314680AbSH3XbZ>; Fri, 30 Aug 2002 19:31:25 -0400
Date: Fri, 30 Aug 2002 16:42:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: bcrl@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compile fix for fs/aio.c on non-highmem systems
In-Reply-To: <20020830.162126.08406551.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208301641150.5430-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, David S. Miller wrote:
> 
>    Patrik Mochel noticed that fs/aio.c doesn't compile on a non-highmem config.  
>    The patch below (and in the bk tree on master.kernel.org:/home/bcrl/aio-2.5) 
>    fixes that by making the helper functions #defines, and should also be a 
>    bit faster.
> 
> Platforms should fix this by making a dummy asm/kmap_types.h
> 
> Linus added the explicit include of asm/kmap_types.h and therefore
> I believe this is how he wants this fixed too.

I don't really much care how it gets fixed, I could equally well imagine
having a dummy struct when CONFIG_HIGHMEM isn't set. Whatever makes the 
dang thing work. There's certainly a good argument that non-broken 
architectures shouldn't need to bother with kmap() at all..

		Linus

