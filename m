Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTLCX1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTLCX1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:27:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:45549 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262397AbTLCX1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:27:09 -0500
Date: Wed, 3 Dec 2003 15:26:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: pinotj@club-internet.fr
cc: nathans@sgi.com, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
In-Reply-To: <mnet1.1070492788.24399.pinotj@club-internet.fr>
Message-ID: <Pine.LNX.4.58.0312031524310.2055@home.osdl.org>
References: <mnet1.1070492788.24399.pinotj@club-internet.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, 4 Dec 2003 pinotj@club-internet.fr wrote:
>
> [slab.c patch from Linus]
>
> I tried the patch on the same small config (XFS and
> CONFIG_DEBUG_PAGEALLOC enabled) and I got oops at the beginning of boot
> sequence. I spent some times to write this down but I'm not so sure it's
> a good news. Just say me it's not a hw problem...

Sorry - it's not a hw problem, and in fact it's a problem with my slab
debugging patch: please don't use CONFIG_DEBUG_SLAB together with my
crappy patch. My patch wants _only_ CONFIG_DEBUG_PAGEALLOC instead of
using the SLAB debugger.

So please turn the slab debugger off, and depend on CONFIG_DEBUG_PAGEALLOC
entirely and try again,

		Linus
