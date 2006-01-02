Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWABIvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWABIvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 03:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWABIvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 03:51:05 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:12678 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932335AbWABIvE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 03:51:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K7Ig3+ezoI9Ru1eby6mhvgkQ8eJiSd2ZD4t6eXY6RCBSLk3nSF5aWotaaa+Bi8ZiQ58JfKCTNMzQeaZBjfC8FAD16gjdbOCDwbKu7/Xf/tI0MrL9aHAhtwR26KaeMj39WXDrPnW7Dn1VpxqcF2Umt45vobNO5l3IVHVK0MvCwZM=
Message-ID: <84144f020601020051l326e163ep7cba5f2fd240dc0d@mail.gmail.com>
Date: Mon, 2 Jan 2006 10:51:03 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Eric Dumazet <dada1@cosmosbay.com>, Denis Vlasenko <vda@ilport.com.ua>,
       Andreas Kleen <ak@suse.de>, Matt Mackall <mpm@selenic.com>
In-Reply-To: <84144f020601020046t3176cde2k7d9ec900cafd6d2f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	 <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua>
	 <200512281054.26703.vda@ilport.com.ua>
	 <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
	 <20051228210124.GB1639@waste.org> <20051229012616.GA3286@redhat.com>
	 <1135915609.6039.39.camel@localhost.localdomain>
	 <84144f020601020046t3176cde2k7d9ec900cafd6d2f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> > Attached is a variant that was refreshed against 2.6.15-rc7 and fixes
> > the logical bug that your compile error fix made ;)
> >
> > It should be cachep->objsize not csizep->cs_size.

On 1/2/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Isn't there any other way to do this patch other than making kzalloc()
> and kstrdup() inline? I would like to see something like this in the
> mainline but making them inline is not acceptable because they
> increase kernel text a lot.

Also, wouldn't it be better to track kmem_cache_alloc and
kmem_cache_alloc_node instead?

                                      Pekka
