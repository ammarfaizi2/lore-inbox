Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289974AbSAWTLE>; Wed, 23 Jan 2002 14:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289981AbSAWTKo>; Wed, 23 Jan 2002 14:10:44 -0500
Received: from zero.tech9.net ([209.61.188.187]:24836 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289979AbSAWTKn>;
	Wed, 23 Jan 2002 14:10:43 -0500
Subject: Re: [PATCH *] rmap VM, version 12
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0201231650450.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201231650450.32617-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 23 Jan 2002 14:15:04 -0500
Message-Id: <1011813305.28682.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-23 at 13:57, Rik van Riel wrote:

> Actually, this is just using the pte_free_fast() and
> {get,free}_pgd_fast() functions on non-pae machines.
> 
> I think this should be safe, unless there is a way
> we could pagefault from inside interrupts (but I don't
> think we do that).
> 
> OTOH, the -preempt people will want to add preemption
> protection from the fiddling with the local pte freelist ;)

If you are using the stock mechanisms in include/asm/pgalloc.h they are
already made preempt-safe by the patch. ;)

	Robert Love

