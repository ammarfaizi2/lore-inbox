Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVAIUnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVAIUnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVAIUnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:43:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:1174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261773AbVAIUmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:42:50 -0500
Date: Sun, 9 Jan 2005 12:42:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Arjan van de Ven <arjan@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
Subject: Re: removing bcopy... because it's half broken
In-Reply-To: <20050109203459.GA28788@infradead.org>
Message-ID: <Pine.LNX.4.58.0501091240550.2339@ppc970.osdl.org>
References: <20050109192305.GA7476@infradead.org> <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
 <20050109203459.GA28788@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jan 2005, Christoph Hellwig wrote:
> 
> We're building with -ffreestanding now, so gcc isn't allowed to emit
> any calls to standard library functions.

Bzzt. It still emits calls to libgcc. 

It cannot _not_ do so. There are simply operations that gcc doesn't 
generate native code for, ie divides on certain architectures etc.

And that very much includes bcopy/memcpy on most architectures.

		Linus
