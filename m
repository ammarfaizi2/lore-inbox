Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287619AbSAHDjg>; Mon, 7 Jan 2002 22:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287629AbSAHDj1>; Mon, 7 Jan 2002 22:39:27 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:55728 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S287619AbSAHDjR>; Mon, 7 Jan 2002 22:39:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Benjamin LaHaise <bcrl@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [BUG] in 2.4.17 after 10 days uptime
Date: Mon, 7 Jan 2002 22:38:58 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020101145605.B3283@redhat.com> <Pine.LNX.4.21.0201071623380.18722-100000@freak.distro.conectiva> <20020107212445.A7376@redhat.com>
In-Reply-To: <20020107212445.A7376@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020108033858.D62D31CB1F@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 09:24 pm, Benjamin LaHaise wrote:
> On Mon, Jan 07, 2002 at 04:28:12PM -0200, Marcelo Tosatti wrote:
> > Is my thinking correct ?
>
> Yes, that's the case I was thinking of.  sendfile() and tux are potential
> triggers of this.
>
> > If so, I don't see why Ed's trace BUGs at rmqueue first: It should bug at
> > __free_pages_ok() PageLRU check.
>
> Hmm, as we've discussed on irc, there are some other nasty implications of
> the __free_pages code interacting with shrink_cache without this patch. 
> I'm not certain that explains it, but it could.  Ed, have you seen this
> oops again?  What kind of load is the machine under?

After applyng your patch I ran for another couple of day on 18pre1 without
seeing any problems.  The system is fairly lightly loaded running a caching
news server, java apps and acts as a masq gateway/squid cache for the rest 
of the boxes here (home network).  It also the box I use...

Ed
