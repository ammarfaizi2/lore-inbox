Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286056AbRLTEE1>; Wed, 19 Dec 2001 23:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286047AbRLTEEQ>; Wed, 19 Dec 2001 23:04:16 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:55432 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S286044AbRLTEEP>;
	Wed, 19 Dec 2001 23:04:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Scheduler ( was: Just a second ) ...
Date: Wed, 19 Dec 2001 20:04:10 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16GuRG-0002Oz-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 19, 2001 19:50, Rik van Riel wrote:
> On Tue, 18 Dec 2001, Linus Torvalds wrote:
> > The thing is, I'm personally very suspicious of the "features for that
> > exclusive 0.1%" mentality.
>
> Then why do we have sendfile(), or that idiotic sys_readahead() ?

Damn straights

sendfile(2) had an oppertunity to be a real extention of the Unix philosophy. 
If it was called something like "copy" (to match "read" and "write"), and 
worked on all fds (even if it didn't do zerocopy, it should still just work), 
it'd fit in a lot more nicely than even BSD sockets. Alas, as it is, it's 
more of a wart than an extention. 

Now, sys_readahead() is pretty much the stupidest thing I've ever heard. If 
we had a copy(2) syscall, we could do the same thing by: copy(sourcefile, 
/dev/null, count). I don't think sys_readahead() even qualifies as a wart. 

-Ryan
