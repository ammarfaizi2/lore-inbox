Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWEVTtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWEVTtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWEVTtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:49:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbWEVTtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:49:16 -0400
Date: Mon, 22 May 2006 12:45:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Zachary Amsden <zach@vmware.com>, jakub@redhat.com,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
In-Reply-To: <20060522191421.GC9847@stusta.de>
Message-ID: <Pine.LNX.4.64.0605221241101.3697@g5.osdl.org>
References: <1147759423.5492.102.camel@localhost.localdomain>
 <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain>
 <20060519174303.5fd17d12.akpm@osdl.org> <20060522162949.GG30682@devserv.devel.redhat.com>
 <4471EA60.8080607@vmware.com> <20060522101454.52551222.akpm@osdl.org>
 <20060522172710.GA22823@elte.hu> <Pine.LNX.4.64.0605221045140.3697@g5.osdl.org>
 <20060522191421.GC9847@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 May 2006, Adrian Bunk wrote:
> 
> Is it a new policy that the kernel mustn't break any buggy userspace 
> code?

It's not a new policy, dammit.

Guys, a kernel developer who cannot understand that user space is 
important should just drop their pretentions of being a kernel developer, 
and go play with some toy system like Hurd instead. There you can say 
"user space doesn't matter".

The kernel has _one_ mission in life, and one mission only. Guess what 
that is? It's to be the buffer between user space and shared resources. 
That's it. NOTHING ELSE MATTERS.

If the kernel breaks user space, the kernel is broken. End of story. 

Yes, there are reasons we must occasionally allow for it anyway, but they 
should all be some pretty damn major ones. Like "we simply _had_ to, there 
was no choice, because the alternatives broke user space more".

Which isn't even _remotely_ the case here.

The whole point of a kernel is that it doesn't do anything for itself. 
It's there to serve user space. 

			Linus
