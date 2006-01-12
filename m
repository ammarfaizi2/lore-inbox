Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWALAOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWALAOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWALAOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:14:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932664AbWALAOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:14:21 -0500
Date: Wed, 11 Jan 2006 16:13:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, linux-kernel@vger.kernel.org, hch@infradead.org,
       ak@suse.de
Subject: Re: [PATCH 3 of 3] Add __raw_memcpy_toio32 to each arch
Message-Id: <20060111161349.565394d1.akpm@osdl.org>
In-Reply-To: <1137024358.17705.33.camel@localhost.localdomain>
References: <patchbomb.1137019194@eng-12.pathscale.com>
	<ee6ce7e55dc7aec0d870.1137019197@eng-12.pathscale.com>
	<20060111154614.47725c23.akpm@osdl.org>
	<1137024358.17705.33.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
> On Wed, 2006-01-11 at 15:46 -0800, Andrew Morton wrote:
> 
> > How's about we add a new linux/io.h which does:
> > 
> > #include <asm/io.h>
> > void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
> 
> I thought about this, and about moving other duplicated definitions from
> asm-*/io.h in here, but I couldn't find any other obvious candidates, so
> I wasn't anxious to introduce a new file.
> 

Well it's obviously better than duplicating the thing.

There are other common things which can be hoisted to linux/io.h, but if we
do that then zillions of .c files need to be changed to include linux/io.h
rather than asm/io.h.  That's a good janitorial thing to do, but I doubt if
you want to do it ;)


