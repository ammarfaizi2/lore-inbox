Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278327AbRJWV7S>; Tue, 23 Oct 2001 17:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278329AbRJWV7I>; Tue, 23 Oct 2001 17:59:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:60178 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278327AbRJWV6v>;
	Tue, 23 Oct 2001 17:58:51 -0400
Date: Tue, 23 Oct 2001 19:59:08 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Issue with max_threads (and other resources) and highmem
In-Reply-To: <91510000.1003871155@baldur>
Message-ID: <Pine.LNX.4.33L.0110231911210.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, Dave McCracken wrote:
> --On Tuesday, October 23, 2001 18:52:35 -0200 Rik van Riel
> <riel@conectiva.com.br> wrote:
>
> > I submitted a patch a while ago to set the number way lower,
> > which was accepted by Alan and in the -ac kernels. A few months
> > later Linus followed and changed the limit in his kernels, too.
>
> Ok, that's what I get for reading the comment and not deciphering the
> code...

*sigh*  So my updated comment got backed out again ;/

Linus, what do you have against correct documentation ? ;)

> But there's still a problem.  The value for mempages is all of physical
> memory including highmem, so a machine with a sufficient amount of high
> memory can set max_threads to a value way too high, given that most if not
> all of the resources it's trying to limit have to come from normal memory
> and not high memory.

Indeed, this needs to be fixed.  A sane upper limit for
max_threads would be 10000, this also keeps in mind the
fact that we only have 32000 possible PIDs, some of which
could be taken by task groups, etc...

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

