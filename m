Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVBBTQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVBBTQB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVBBTLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:11:07 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:27024 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262335AbVBBTGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:06:39 -0500
Date: Wed, 2 Feb 2005 11:05:14 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: David Woodhouse <dwmw2@infradead.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: A scrub daemon (prezeroing)
In-Reply-To: <20050202153256.GA19615@logos.cnet>
Message-ID: <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Marcelo Tosatti wrote:

> Sounds very interesting idea to me. Guess it depends on whether the cost of
> DMA write for memory zeroing, which is memory architecture/DMA engine dependant,
> offsets the cost of CPU zeroing.
>
> Do you have any thoughts on that?
>
> I wonder if such thing (using unrelated devices DMA engine's for zeroing) ever been
> done on other OS'es?
>
> AFAIK SGI's BTE is special purpose hardware for memory zeroing.

Nope the BTE is a block transfer engine. Its an inter numa node DMA thing
that is being abused to zero blocks.

The same can be done with most DMA chips (I have done so on some other
platforms not on i386)

