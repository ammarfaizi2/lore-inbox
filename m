Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277544AbRJESuH>; Fri, 5 Oct 2001 14:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277548AbRJESt6>; Fri, 5 Oct 2001 14:49:58 -0400
Received: from waste.org ([209.173.204.2]:10811 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S277547AbRJEStr>;
	Fri, 5 Oct 2001 14:49:47 -0400
Date: Fri, 5 Oct 2001 13:51:50 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
In-Reply-To: <Pine.LNX.4.33.0110051041050.1819-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0110051345450.30494-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Linus Torvalds wrote:

> On Fri, 5 Oct 2001, Horst von Brand wrote:
>
> > Linus Torvalds <torvalds@transmeta.com> said:
> > > On 5 Oct 2001, Eric W. Biederman wrote:
> >
> > [...]
> >
> > > > Currently checking to see if the file is executable looks good
> > > > enough.
> > >
> > > [ executable by the user in question, not just anybody ]
> > >
> > > Yes, I suspect it is.
> >
> > Who is "user in question"? It is quite legal (if strange) to have a file
> > user A can modify, but not execute, while B can execute it.
>
> The "user in question" being the one that actually does the
> mmap(MAP_DENYWRITE). If _he_ can execute the file, that would be
> reason enough to think that he can deny others from writing to it while he
> has it mapped..

This violates principle of least surprise. It _should_ be harmless for an
admin to mark /var/log/utmp +x, yes? Stupid, but harmless. Now suppose it
lives on VFAT...

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

