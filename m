Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWABNaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWABNaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWABNaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:30:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:4486 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750719AbWABNaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:30:18 -0500
Date: Mon, 2 Jan 2006 14:29:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: [patch 03/13] mutex subsystem, add include/asm-i386/mutex.h
Message-ID: <20060102132943.GA30730@elte.hu>
References: <200512310140_MC3-1-B501-E855@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512310140_MC3-1-B501-E855@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <20051229210336.GD665@elte.hu>
> 
> On Thu, 29 Dec 2005 at 22:03:36 +0100, Ingo Molnar wrote:
> 
> > +#define __mutex_fastpath_lock(count, fn_name)                                \
> > +do {                                                                 \
> > +     /* type-check the function too: */                              \
> > +     void fastcall (*__tmp)(atomic_t *) = fn_name;                   \
> > +     unsigned int dummy;                                             \
> > +                                                                     \
> > +     (void)__tmp;                                                    \
> > +     typecheck(atomic_t *, count);                                   \
> 
>  The function type checking is ugly.  Wouldn't this be better?
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

thanks, applied.

	Ingo
