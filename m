Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTK2RN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTK2RN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:13:29 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:25475
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263857AbTK2RNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:13:22 -0500
Date: Sat, 29 Nov 2003 12:12:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] kmem_cache_alloc_node
In-Reply-To: <3FC8C794.50005@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0311291154060.1646@montezuma.fsmlabs.com>
References: <3FC8C794.50005@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.58.0311291154062.1646@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Nov 2003, Manfred Spraul wrote:

> I've written a prototype kmem_cache_alloc_node function: I'm not yet
> convinced that it's really necessary to guarantee that kmalloc and
> kmem_cache_alloc are strictly node-local (adds noticable costs to the
> hot paths, and many objects will be touched by multiple nodes anyway),
> but at least the cpu bound data structures should be allocated from the
> right node.
> The attached patch adds a simple kmem_cache_alloc_node function and
> moves the cpu local structures within slab onto the right node.
> One problem is the bootstrap: there is an
> alloc_pages_node(,,cpu_to_node()) during CPU_UP_PREPARE: Does that work,
> or is that too early?
> Please test it, I don't have access to suitable hardware.
>
> The patch also includes fixes for two accounting bugs in error paths,
> I'll send them seperately to Andrew.

Hi Manfred,
	I just booted this patch on a 4 quad NUMAQ successfully, this was
only a test boot, i'll get around to having a closer look a bit later on.

Thanks
