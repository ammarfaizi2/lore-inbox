Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277524AbRJERou>; Fri, 5 Oct 2001 13:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277472AbRJERok>; Fri, 5 Oct 2001 13:44:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62225 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277424AbRJERo1>; Fri, 5 Oct 2001 13:44:27 -0400
Date: Fri, 5 Oct 2001 10:44:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
In-Reply-To: <200110051735.f95HZ4ou003296@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.33.0110051041050.1819-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Oct 2001, Horst von Brand wrote:

> Linus Torvalds <torvalds@transmeta.com> said:
> > On 5 Oct 2001, Eric W. Biederman wrote:
>
> [...]
>
> > > Currently checking to see if the file is executable looks good
> > > enough.
> >
> > [ executable by the user in question, not just anybody ]
> >
> > Yes, I suspect it is.
>
> Who is "user in question"? It is quite legal (if strange) to have a file
> user A can modify, but not execute, while B can execute it.

The "user in question" being the one that actually does the
mmap(MAP_DENYWRITE). If _he_ can execute the file, that would be
reason enough to think that he can deny others from writing to it while he
has it mapped..

		Linus

