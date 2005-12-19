Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVLSQjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVLSQjC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVLSQjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:39:01 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:37829 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964830AbVLSQjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:39:00 -0500
Date: Mon, 19 Dec 2005 17:38:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 10/15] Generic Mutex Subsystem, mutex-migration-helper-core.patch
Message-ID: <20051219163818.GE8160@elte.hu>
References: <20051219013837.GF28038@elte.hu> <1135001565.13138.247.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135001565.13138.247.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 2005-12-19 at 02:38 +0100, Ingo Molnar wrote:
> > +#ifdef CONFIG_DEBUG_MUTEX_FULL
> > +# define semaphore             mutex_debug
> > +# define DECLARE_MUTEX         DEFINE_MUTEX_DEBUG
> > +#else
> > +# define DECLARE_MUTEX         ARCH_DECLARE_MUTEX
> > +#endif
> > +
> > +# define DECLARE_MUTEX_LOCKED  ARCH_DECLARE_MUTEX_LOCKED
> > +
> > +#if 0
> 
> Probably not good to have #if 0 in release patches.

yeah - i'll zap it.

	Ingo
