Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWBVVv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWBVVv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWBVVv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:51:56 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:3456 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750714AbWBVVvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:51:55 -0500
Date: Wed, 22 Feb 2006 16:45:45 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 5/6] lightweight robust futexes: i386
To: "Ulrich Drepper" <drepper@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Ulrich Drepper" <drepper@redhat.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Ingo Molnar" <mingo@elte.hu>
Message-ID: <200602221648_MC3-1-B90A-1A02@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <a36005b50602210838wa87764eof7b5d6e5a8a5ab3a@mail.gmail.com>

On Tue, 21 Feb 2006 at 08:38:04 -0800, Ulrich Drepper wrote:
> On 2/21/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > > +             : "=a" (oldval), "=m" (*uaddr)
> >                                  ^^^^
> >    Should be "+m" because it's both read and written.
> 
> No, this is why there is the "0" input parameter.

 But this is arg 1, not 0. With a memory clobber it's irrelevant
anyway though.

> > > +             : "memory"
> >                   ^^^^^^^^
> >    Is this necessary? Every possible memory location that could be
> > affected has been listed in the operands if the above change is made.
>
> This makes the asm a barrier for the compiler.

 A comment to that effect would be nice; IOW document the reason for it.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

