Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbRCZTKx>; Mon, 26 Mar 2001 14:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRCZTKo>; Mon, 26 Mar 2001 14:10:44 -0500
Received: from code.and.org ([63.113.167.33]:44514 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S132562AbRCZTKf>;
	Mon, 26 Mar 2001 14:10:35 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Guest section DW <dwguest@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.33.0103222033220.24040-100000@duckman.distro.conectiva>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 26 Mar 2001 14:04:04 -0500
In-Reply-To: Rik van Riel's message of "Thu, 22 Mar 2001 20:37:11 -0300 (BRST)"
Message-ID: <nn66gwnyhn.fsf@code.and.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Rik van Riel <riel@conectiva.com.br> writes:

> On Fri, 23 Mar 2001, Guest section DW wrote:
> > On Thu, Mar 22, 2001 at 10:52:09PM +0000, Alan Cox wrote:
> >
> > > You can do overcommit avoidance in Linux if you are bored enough to try it.
> >
> > Would you accept it as the default? Would Linus?
> 
> It wouldn't help.  Suppose you run without overcommit and you
> fill up RAM and swap to the last page.
> 
> Then you change the size of one of the windows on your desktop
> and a program gets sent -SIGWINCH.

 Ignoring the fact that most people don't use a tty based desktop, and
that I'm pretty happy having my desktop die in flames when OOM (my DNS
or smtp server on the other hand...).

>                                    In order to process this
> signal, the program needs to allocate some variables on its
> stack, possibly needing a new page to be allocated for its
> stack ...

man sigaltstack

> ... and since this is something which could happen to any program
> on the system, the result of non-overcommit would be getting a
> random process killed (though not completely random, syslogd and
> klogd would get killed more often than the others).

 I fail to see why, stack usage can be limited (and possibly cleanly
handled by having a prctl() to say make sure X pages are available on
the stack).

 If you want overcommit great, and I think it's a valid default
... but it'd be nice if I could say I don't want it for apps that
aren't written using glib etc.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
