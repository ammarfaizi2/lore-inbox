Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265652AbSKAH4n>; Fri, 1 Nov 2002 02:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265653AbSKAH4n>; Fri, 1 Nov 2002 02:56:43 -0500
Received: from ns.suse.de ([213.95.15.193]:2321 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265652AbSKAH4m>;
	Fri, 1 Nov 2002 02:56:42 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] faster kmalloc lookup
References: <3DBAEB64.1090109@colorfullife.com.suse.lists.linux.kernel> <1036056917.2872.0.camel@dhcp59-228.rdu.redhat.com.suse.lists.linux.kernel> <3DC1B6D0.8050202@colorfullife.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Nov 2002 09:03:09 +0100
In-Reply-To: Manfred Spraul's message of "1 Nov 2002 00:12:44 +0100"
Message-ID: <p73adktson6.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> is there a simpler way to achieve that? Right now the list of kmalloc 
> caches exists in 3 copies, which could easily get out of sync.

x86-64 system calls had a similar problem. I solved it by putting
them into a separate file with macros and including it multiple 
times with different macro definitions.

It would be quite useful to have it in a separate file: I'm still
toying with the idea to write a memory profiler to compute a better
list of slab sizes than the relatively dumb power of two default. Previously
it was trivial to change the table at boot, now it would be a bit
easier at least if it was a simple file that could be easily
rewritten.

-Andi
