Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSEaAM7>; Thu, 30 May 2002 20:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSEaAM6>; Thu, 30 May 2002 20:12:58 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:34517 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S311752AbSEaAM5>; Thu, 30 May 2002 20:12:57 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Keith Owens <kaos@ocs.com.au>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Date: Thu, 30 May 2002 17:09:16 -0700 (PDT)
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <E17DZCa-0007hI-00@starship>
Message-ID: <Pine.LNX.4.44.0205301704550.23527-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2002, Daniel Phillips wrote:

> On Thursday 30 May 2002 23:55, Ion Badulescu wrote:
> > On Thu, 30 May 2002 11:45:14 +0200, Daniel Phillips <phillips@bonn-fries.net> wrote:
> >
> > That's the biggest problem of kbuild25: maintainability of the
> > configure+make replacement that Keith is using. Enough people know
> > make and makefiles that the existing system can be fixed or at least
> > made to work reasonably well. Not the same thing can be said about
> > the 10000-line brand-new make augmenter in kbuild25.
>
> It's quite readable and understandable.  I must say I find it easier
> to comprehend than the current system.  Part of that is the extensive
> documentation and another part is that appears to be well thought out
> and constructed according to sound software engineering principles.
>

don't forget that the kbuild2.5 patch was a lot smaller before keith was
told to "go away and don't bother anyone until the speed problem is fixed"
a large part of the fix was to use the mmapped db stuff that Larry McVoy
made available instead of useing the standard db libraries on the system.

one possible way to make this more 'incramental' would be to make a
version of kbuild2.5 that used the standard db stuff and is 200% slower
then the existing kbuild and then after it's accepted put in the patch to
speed it up to where it's 17% faster (IIRC the numbers Daniel posted
earlier today) by converting the db that's used. Somehow I doubt that
crippling the speed mearly to make it 'incramental' would make many people
happy.

David Lang
