Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293026AbSCRVeg>; Mon, 18 Mar 2002 16:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293027AbSCRVe0>; Mon, 18 Mar 2002 16:34:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:456 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293026AbSCRVeU>;
	Mon, 18 Mar 2002 16:34:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: george anzinger <george@mvista.com>, Joel Becker <jlbec@evilplan.org>
Subject: Re: [Lse-tech] Re: [PATCH] Re: futex and timeouts
Date: Mon, 18 Mar 2002 16:35:03 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rusty Russell <rusty@rustcorp.com.au>, matthew@hairy.beasts.org,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> <20020315192818.R4836@parcelfarce.linux.theplanet.co.uk> <3C929BF0.3CDC58AB@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020318213411.6E2BA3FE07@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 March 2002 08:12 pm, george anzinger wrote:
> Joel Becker wrote:
> > On Fri, Mar 15, 2002 at 01:59:38PM -0500, Hubertus Franke wrote:
> > > > > What I would like to see is an interface that lets me pass optional
> > > > > parameters to the syscall interface, so I can call with different
> > > > > number of parameters.
> > > >
> > > >     Is this to lock multiple futexes "atomically"?  If we are
> > > > looking for a fast path stack-wise, this seems extra work.
> > >
> > > No, take for example...
> > >
> > > syscall3(int,futex,int,op, struct futex*, futex, int opt_arg);
>
> I don't think there is anything "broken" in defining more than one
> syscall stub to the same system call, each with a different parameter
> count (or completely different arguments).  The call code will need to
> be able to figure it out, but there is nothing in the way as far as
> doing it.
>
> -g
>

Ofcourse, no difficulties here, but no convenient way either, as the 
__NR_futex is automatically used.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
