Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUEXIUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUEXIUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUEXIUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:20:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9929 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262906AbUEXIUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:20:13 -0400
Date: Mon, 24 May 2004 04:19:58 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arnd@arndb.de, drepper@redhat.com, linux-kernel@vger.kernel.org,
       mingo@redhat.com, schwidefsky@de.ibm.com, bert hubert <ahu@ds9a.nl>
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-ID: <20040524081958.GD4736@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040520233639.126125ef.akpm@osdl.org> <20040521074358.GG30909@devserv.devel.redhat.com> <200405221858.44752.arnd@arndb.de> <20040524073407.GC4736@devserv.devel.redhat.com> <20040524011203.3be81d0a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524011203.3be81d0a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 01:12:03AM -0700, Andrew Morton wrote:
> Jakub Jelinek <jakub@redhat.com> wrote:
> >
> > That said, NPTL can deal with any of these variants and the decision
> >  is up to Martin I think (assuming the base patch gets accepted, that is).
> 
> Well the race is real and does need a kernel fix, so I queued it up.  I
> guess if the new argument to sys_futex() breaks some architecture they can
> independently add a new syscall for it, or send a fix.  Mutter.
> 
> It's a bit of a shame that you need to be a rocket scientist to 
> understand the futex syscall interface.  Bert, are you still maintaining
> the manpage?  If so, is there enough info here to update it?

The latest futex(2) or futex(4) manpage I saw doesn't mention FUTEX_REQUEUE
at all.
Also, any futex man page should probably SEE ALSO Ulrich's futex paper:
http://people.redhat.com/drepper/futex.pdf
which helps understanding how to successfully use futexes, because
it is certainly not trivial.

	Jakub
