Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312548AbSCZRB7>; Tue, 26 Mar 2002 12:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312550AbSCZRBt>; Tue, 26 Mar 2002 12:01:49 -0500
Received: from web13602.mail.yahoo.com ([216.136.175.113]:5391 "HELO
	web13602.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312548AbSCZRBi>; Tue, 26 Mar 2002 12:01:38 -0500
Message-ID: <20020326170137.8553.qmail@web13602.mail.yahoo.com>
Date: Tue, 26 Mar 2002 09:01:37 -0800 (PST)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: Re: readv() return and errno
To: Andries.Brouwer@cwi.nl, jholly@cup.hp.com, plars@austin.ibm.com
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <UTC200203261619.QAA368367.aeb@cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree it is not a big thing at all, zero not
returning any error. Yes! I read and understood the
MAY return an error, it makes complete sense.

I agree, the Linux man pages need a lot of work,
if they are going to be even close to reflecting
some of things in the kernel.


Thanks,
Balbir

--- Andries.Brouwer@cwi.nl wrote:
> Jim Hollenback wrote:
> 
> > According to readv(2) EINVAL is returned for an
> invalid
> > argument.
> 
> Right.
> 
> > The examples given were count might be greater
> than
> > MAX_IOVEC or zero.
> 
> Wrong, or at least confusingly phrased.
> 
> 
> In the good old days, a man page described what the
> system did,
> and the ERRORS section gave the reasons for the
> possible error
> returns.
> These days a man page describes a function present
> on many
> Unix-like systems, and not all systems have
> precisely the
> same behaviour. POSIX man pages therefore
> distinguish under
> ERRORS the two possibilities "if foo then this error
> must be
> returned", and "if foo then this error may be
> returned".
> 
> Linux man pages do not (yet) make this distinction -
> adding this is a lot of careful work, and so far
> nobody is doing this [hint..].
> In other words, the ERRORS section in Linux man
> pages is
> to be interpreted as "if foo then this error may be
> returned".
> 
> Note that it may not be desirable at all to do
> things that way,
> there is no need for kernel patches, it just means
> that systems
> exist with this behaviour, so that authors of
> portable programs
> must take this into account.
> 
> Balbir Singh wrote:
> 
> > Apply this trivial patch, if you want the required
> behaviour
> 
> But the behaviour is not required.
> Paul Larson makes the same mistake.
> 
> Andries


__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
