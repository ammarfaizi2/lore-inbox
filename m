Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267584AbUHEHTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267584AbUHEHTS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267586AbUHEHTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:19:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:9901 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267584AbUHEHTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:19:16 -0400
Date: Thu, 5 Aug 2004 00:17:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: inaky.perez-gonzalez@intel.com, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org, rusty@rustcorp.com.au, mingo@elte.hu,
       jamie@shareable.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Message-Id: <20040805001737.78afb0d6.akpm@osdl.org>
In-Reply-To: <4111DC8C.7050504@redhat.com>
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
	<20040804232123.3906dab6.akpm@osdl.org>
	<4111DC8C.7050504@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
>
> Andrew Morton wrote:
> 
> > This fixes what appear to be some fairly significant shortcomings.  What do
> > the futex and NPTL people have to say about the gravity of the problems
> > which this solves, and the offered implementation?
> 
> This code will not be suppoerted by the glibc code.  Using these
> primitives would mean significant slowdown of all operations and this
> for problems which only a few people have.

How large is the slowdown, and on what workloads?

>  I asked to get the useful
> parts of the code to be made available using the current futex interface
> (robust mutexes are useful)

Passing the lock to a non-rt task when there's an rt-task waiting for it
seems pretty poor form, too.

