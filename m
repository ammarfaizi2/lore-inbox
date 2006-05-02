Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWEBSla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWEBSla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWEBSla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:41:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964963AbWEBSla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:41:30 -0400
Date: Tue, 2 May 2006 11:41:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: David Woodhouse <dwmw2@infradead.org>, js@linuxtv.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
In-Reply-To: <20060502101113.17c75a05.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0605021137500.4086@g5.osdl.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
 <1146503166.2885.137.camel@hades.cambridge.redhat.com> <20060502003755.GA26327@linuxtv.org>
 <1146576495.14059.45.camel@pmac.infradead.org> <20060502142050.GC27798@linuxtv.org>
 <1146580308.17934.19.camel@pmac.infradead.org> <20060502101113.17c75a05.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 May 2006, Randy.Dunlap wrote:
> +
> +     Although it would only take a short amount of time for the eyes and
> +     brain to become accustomed to the standard types like 'uint32_t',
> +     some people object to their use anyway.

The problem with uint32_t is that it's ugly, it used to be unportable, and 
you can't use it in header files _anyway_.

In other words, there's no _point_ to the "standard type". 

I really object to this whole thing. The fact is, "u8" and friends _are_ 
the standard types as far as the kernel is concerned.  Claiming that they 
aren't is just silly.

It's the "uint32_t" kind of thing that isn't standard within the kernel. 
You can't use that thing in public header files anyway due to name scoping 
rules, so they have basically no redeeming features.

			Linus
