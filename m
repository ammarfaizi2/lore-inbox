Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVL3KZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVL3KZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 05:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVL3KZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 05:25:47 -0500
Received: from ns1.suse.de ([195.135.220.2]:59625 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751240AbVL3KZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 05:25:46 -0500
Date: Fri, 30 Dec 2005 11:25:35 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230102534.GA7222@wotan.suse.de>
References: <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051229143846.GA18833@infradead.org> <1135868049.2935.49.camel@laptopd505.fenrus.org> <20051229153529.GH3811@stusta.de> <20051229154241.GY22293@devserv.devel.redhat.com> <p73oe2zexx9.fsf@verdi.suse.de> <20051230094045.GA5799@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230094045.GA5799@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 10:40:45AM +0100, Ingo Molnar wrote:
>     text    data     bss     dec     hex filename
>  4080998  870384  387260 5338642  517612 vmlinux-orig
>  4084421  872024  387260 5343705  5189d9 vmlinux-inline
>  4010957  834048  387748 5232753  4fd871 vmlinux-inline+units
>  4010039  833112  387748 5230899  4fd133 vmlinux-inline+units+fixes
>  4007617  833120  387748 5228485  4fc7c5 vmlinux-inline+units+fixes+capable
> 
> or a 1.8% code size reduction.

But again if you only look at text size you ideally would want
to never inline anything, except the cases above and only called
once functions. So just turn it off except when forced? That would
be the logical conclusion from your strategy. I'm not sure it's a good
one.

-Andi
