Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312354AbSCZQUb>; Tue, 26 Mar 2002 11:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312358AbSCZQUV>; Tue, 26 Mar 2002 11:20:21 -0500
Received: from hera.cwi.nl ([192.16.191.8]:32901 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312354AbSCZQUM>;
	Tue, 26 Mar 2002 11:20:12 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 26 Mar 2002 16:19:39 GMT
Message-Id: <UTC200203261619.QAA368367.aeb@cwi.nl>
To: balbir_soni@yahoo.com, jholly@cup.hp.com, plars@austin.ibm.com
Subject: Re: readv() return and errno
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Hollenback wrote:

> According to readv(2) EINVAL is returned for an invalid
> argument.

Right.

> The examples given were count might be greater than
> MAX_IOVEC or zero.

Wrong, or at least confusingly phrased.


In the good old days, a man page described what the system did,
and the ERRORS section gave the reasons for the possible error
returns.
These days a man page describes a function present on many
Unix-like systems, and not all systems have precisely the
same behaviour. POSIX man pages therefore distinguish under
ERRORS the two possibilities "if foo then this error must be
returned", and "if foo then this error may be returned".

Linux man pages do not (yet) make this distinction -
adding this is a lot of careful work, and so far
nobody is doing this [hint..].
In other words, the ERRORS section in Linux man pages is
to be interpreted as "if foo then this error may be returned".

Note that it may not be desirable at all to do things that way,
there is no need for kernel patches, it just means that systems
exist with this behaviour, so that authors of portable programs
must take this into account.

Balbir Singh wrote:

> Apply this trivial patch, if you want the required behaviour

But the behaviour is not required.
Paul Larson makes the same mistake.

Andries
