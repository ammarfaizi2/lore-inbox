Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312395AbSCZUZV>; Tue, 26 Mar 2002 15:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312425AbSCZUZK>; Tue, 26 Mar 2002 15:25:10 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:1290 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S312395AbSCZUZA>; Tue, 26 Mar 2002 15:25:00 -0500
Date: Tue, 26 Mar 2002 12:24:58 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andreas Hartmann <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <E16pE0U-00073m-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203261210540.26944-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Alan Cox wrote:

> > > My system cannot (short of a bug) go OOM. Thats what the new overcommit
> > > mode 2/3 ensures
> >
> > How does a process react that doesn't get no more memory?
>
> Thats up to the process. If a program doesn't handle malloc/mmap/etc
> failures then its junk anyway

what's the point if you're just going to get signal delivery when you
least want it, even when malloc returns non-NULL?  it could even be due to
stack growth which the compiler is under control of and has no exception
mechanism available.  i personally prefer to take the signal and exit,
it's guaranteed to work in all cases.  (hence, apache-1.3 and other
multiprocess daemon superiority over threaded and event-driven code, tee
hee :)

-dean

