Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWAFLcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWAFLcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWAFLcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:32:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:24805 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932407AbWAFLcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:32:12 -0500
Date: Fri, 6 Jan 2006 12:31:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 10/21] mutex subsystem, debugging code
Message-ID: <20060106113136.GA18323@elte.hu>
References: <20060105153804.GK31013@elte.hu> <1136497623.22868.180.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136497623.22868.180.camel@stark>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Helsley <matthltc@us.ibm.com> wrote:

> > Index: linux/kernel/fork.c
> > ===================================================================
> > --- linux.orig/kernel/fork.c
> > +++ linux/kernel/fork.c
> > @@ -973,6 +973,10 @@ static task_t *copy_process(unsigned lon
> >   	}
> >  #endif
> >  
> > +#ifdef CONFIG_DEBUG_MUTEXES
> > +	p->blocked_on = NULL; /* not blocked yet */
> > +#endif
> > +
> >  	p->tgid = p->pid;
> >  	if (clone_flags & CLONE_THREAD)
> >  		p->tgid = current->tgid;
> 
> Should there be a corresponding initialization of init's blocked_on 
> field in include/linux/init_task.h?

no, since it's initialized to zero.

	Ingo
