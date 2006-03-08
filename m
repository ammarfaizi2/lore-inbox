Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWCHRfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWCHRfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWCHRfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:35:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751219AbWCHRfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:35:14 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603080817500.5481@schroedinger.engr.sgi.com> 
References: <Pine.LNX.4.64.0603080817500.5481@schroedinger.engr.sgi.com>  <31492.1141753245@warthog.cambridge.redhat.com> 
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 17:35:08 +0000
Message-ID: <10414.1141839308@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:

> You need to explain the difference between the compiler reordering and the 
> control of the compilers arrangement of loads and stores and the cpu 
> reordering of stores and loads.

Hmmm... I would hope people looking at this doc would understand that, but
I'll see what I can come up with.

> Note that IA64 has a much more complete set of means to reorder stores and
> loads. i386 and x84_64 processors can only do limited reordering. So it may
> make sense to deal with general reordering and then explain i386 as a
> specific limited case.

Don't you need to use sacrifice_goat() for controlling the IA64? :-)

Besides, I'm not sure that I need to explain that any CPU is a limited case;
I'm primarily trying to define the basic minimal guarantees you can expect
from using a memory barrier, and what might happen if you don't. It shouldn't
matter which arch you're dealing with, especially if you're writing a driver.

I tried to create arch-specific sections for describing arch-specific implicit
barriers and the extent of the explicit memory barriers on each arch, but the
i386 section was generating lots of exceptions that it looked infeasible to
describe them; besides, you aren't allowed to rely on such features outside of
arch code (I count arch-specific drivers as "arch code" for this).

> See the "Intel Itanium Architecture Software Developer's Manual" 
> (available from intels website). Look at Volume 1 section 2.6 
> "Speculation" and 4.4 "Memory Access"

I've added that to the refs, thanks.

> Also the specific barrier functions of various locking elements varies to 
> some extend.

Please elaborate.

David
