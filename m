Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVLUL7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVLUL7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVLUL7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:59:50 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49592 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932383AbVLUL7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:59:38 -0500
Message-Id: <200512202035.jBKKZSHS003621@laptop11.inf.utfsm.cl>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch 
In-Reply-To: Message from Steven Rostedt <rostedt@goodmis.org> 
   of "Tue, 20 Dec 2005 14:43:30 CDT." <Pine.LNX.4.58.0512201437120.11245@gandalf.stny.rr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Tue, 20 Dec 2005 17:35:28 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 21 Dec 2005 08:56:26 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:

[...]

> Let me restate, that the generic code should not be this, but each arch
> can have this if they already went through great lengths in making a fast
> semaphore.
> 
> Heck put the above defines in the generic code, with a define
> 
> linux/mutex.h:
> 
> #ifdef HAVE_ARCH_MUTEX
> #include <asm/mutex.h>
> #else
> 
> #ifdef HAVE_FAST_SEMAPHORE
> 
> #define <defines here>
> 
> #else
> 
> generic code here

Anything to go here could/should very well be in the above arch-specific
file. Saves you a #define ;-)

> #endif /* HAVE_FAST_SEMAPHORE */
> #endif /* HAVE_ARCH_MUTEX */
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
