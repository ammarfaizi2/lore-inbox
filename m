Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTETL5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 07:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTETL5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 07:57:33 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:58829 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263737AbTETL4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 07:56:34 -0400
Date: Tue, 20 May 2003 11:12:28 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Message-ID: <20030520111228.I626@nightmaster.csn.tu-chemnitz.de>
References: <20030520014836.C7BDE2C069@lists.samba.org> <Pine.LNX.4.44.0305200821010.2445-100000@localhost.localdomain> <20030520075627.A28002@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030520075627.A28002@infradead.org>; from hch@infradead.org on Tue, May 20, 2003 at 07:56:27AM +0100
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19I5vx-0000nB-00*75sg.VDA/FE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 20, 2003 at 07:56:27AM +0100, Christoph Hellwig wrote:
> On Tue, May 20, 2003 at 08:27:03AM +0200, Ingo Molnar wrote:
> > yes, but the damage has been done already, and now we've got to start the
> > slow wait for the old syscall to flush out of our tree.
> 
> Actually it should go away before 2.6.0.  sys_futex never was part of a
> released stable kernel so having the old_ version around is silly.  I
> Think it's enough time until 2.6 hits the roads for people to have those
> vendor libc flushed out that use it.  (and sys_futex still isn't used
> in the glibc CVS, only in the addon nptl package with pre-1 release
> numbers.)

This sounds reasonable. The people who shipped that already to
customers have so heavily patched kernels, that this simple patch
for the old sys_futex shouldn't really matter.

But cluttering the kernel with an API/ABI that was born in the
same development cycle, where it has been obsoleted sounds not
worth the bytes it consumes. And so we have a syscall slot
available for the next development cycle.

Or did anybody promise that this was final already? Usally this
promise comes with x.even.y not with x.odd.y .

Regards

Ingo Oeser
