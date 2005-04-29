Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVD2A4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVD2A4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 20:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVD2A4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 20:56:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:17637 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262358AbVD2A4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 20:56:15 -0400
Date: Thu, 28 Apr 2005 17:56:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: timur.tabi@ammasso.com, roland@topspin.com, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050428175609.1893c8bd.akpm@osdl.org>
In-Reply-To: <1113840973.6274.84.camel@laptopd505.fenrus.org>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<4263DBBF.9040801@ammasso.com>
	<1113840973.6274.84.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> > Why do you call mlock() and get_user_pages()?  In our code, we only call mlock(), and the 
> > memory is pinned. 
> 
> this is a myth; linux is free to move the page about in physical memory
> even if it's mlock()ed!!

eh?  I guess the kernel _is_ free to move the page about, but it doesn't.

We might do at some time in the future for memory hotplug, I guess.
