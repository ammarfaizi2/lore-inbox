Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWFFHB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWFFHB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWFFHB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:01:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57308 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932123AbWFFHB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:01:58 -0400
To: Chris Wright <chrisw@sous-sol.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: merging new drivers (was Re: 2.6.18 -mm merge plans)
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060605013223.GD17361@havoc.gtf.org>
	<20060605065856.GA1313@electric-eye.fr.zoreil.com>
	<1149503559.30554.10.camel@localhost.localdomain>
	<1149503784.3111.48.camel@laptopd505.fenrus.org>
	<20060606020245.GN29676@moss.sous-sol.org>
From: Andi Kleen <ak@suse.de>
Date: 06 Jun 2006 09:01:48 +0200
In-Reply-To: <20060606020245.GN29676@moss.sous-sol.org>
Message-ID: <p73pshmzs0z.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> writes:

> * Arjan van de Ven (arjan@infradead.org) wrote:
> > On Mon, 2006-06-05 at 11:32 +0100, Alan Cox wrote:
> > > It isn't just drivers. Xen has the same problem.
> > 
> > Xen has many problems. This is not nearly their biggest ;)
> 
> What is the biggest, or even top 3 or 5?  I've a todo list of some

I would say the biggest is that things haven't gotten submitted
for so long and aren't not resubmitted quickly.

e.g. Xen code needs a lot of arch/* cleanups in small patches that should
be just submitted, fixed, resubmitted quickly.  Many of them
could be already merged.

For example Jan Beulich has been sending many of the cleanups he 
needed for x86-64/i386 Xen immediately and at least for x86-64 
I merged most of them. If the other things were submitted
earlier a lot of it could be already merged too.

Then Xen net/block/char etc. drivers should be submitted to the
respective maintainers independently (they are useful even without the
rest of Xen in HVM guests)

> 140-odd entries which are being worked on.  It's slow and tedious,
> but in progress. 

What I would do is to concentrate on the small cleanup patches first
and post them as soon as you fix them. I think a lot of them were
actually ok without changes. Then bigger stuff piece by piece. You
don't need to wait to fix everything first.

-Andi
