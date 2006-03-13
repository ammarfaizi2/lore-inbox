Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWCMVql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWCMVql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWCMVql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:46:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38596 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932464AbWCMVqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:46:40 -0500
Date: Mon, 13 Mar 2006 13:46:33 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()
In-Reply-To: <9a8748490603131333o1b252aeq9e7f4aca97295640@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603131344480.13027@schroedinger.engr.sgi.com>
References: <200603121428.08226.jesper.juhl@gmail.com> 
 <20060312144129.0b5c227d.akpm@osdl.org>  <9a8748490603122334h6682be62r18f781003db88b20@mail.gmail.com>
 <9a8748490603131333o1b252aeq9e7f4aca97295640@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006, Jesper Juhl wrote:

> Ok, I've been playing around with a few ways to resolve this, but I'm
> a bit pressed for time and won't have properly tested patches ready
> tonight. I will however keep at this, so you'll see patches
> releatively shortly, just give me another day or two and I'll have
> this fixed in a nice way (nice little task to work at :) ...

Maybe extract a alloc_kmemlist_node and free_kmemlist_node from 
alloc_kmemlist()? It gets a bit complicated if all of this is handled within 
alloc_kmemlist and having these separate may simplify recovery on out of 
memory.


