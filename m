Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319698AbSIMQgE>; Fri, 13 Sep 2002 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319704AbSIMQgE>; Fri, 13 Sep 2002 12:36:04 -0400
Received: from h66-38-216-165.gtconnect.net ([66.38.216.165]:45829 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S319698AbSIMQgD>;
	Fri, 13 Sep 2002 12:36:03 -0400
Date: Fri, 13 Sep 2002 12:40:55 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Giuliano Pochini <pochini@shiny.it>
cc: Helge Hafting <helgehaf@aitel.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Killing/balancing processes when overcommited
In-Reply-To: <XFMail.20020913150221.pochini@shiny.it>
Message-ID: <Pine.LNX.4.44.0209131240020.1403-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Giuliano Pochini wrote:

> Date: Fri, 13 Sep 2002 15:02:21 +0200 (CEST)
> From: Giuliano Pochini <pochini@shiny.it>
> To: Helge Hafting <helgehaf@aitel.hist.no>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Killing/balancing processes when overcommited
>
>
> > This is hard to setup, and has the some weaknesses:
> > 1. You worry only about apps you _know_.  But the guy who got
> > his netscape or make -j killed will rename his
> > copies of these apps to something else so your carefully
> > set up oom killer won't know what is running.
> > (How much memory is the "mybrowser" app supposed to use?)
> > Or he'll get another software package that you haven't heard of.
> >
> > 2. Lots and lots of people running netscapes using
> > only 70M each will still be too much.  Think of
> > a university with xterms and then they all
> > goes to cnn.com or something for the latest news
> > about some large event.
> >
> > Even nice well-behaved apps
> > is bad when there is unusually many of them. [...]
>
> That's obvious. The point is that the sysadmin should be
> able to hint the oom killer as much as possible.
> The current linux/mm/oom_kill.c:badness() takes into account
> many factors. The sysadmin should be able to affect the
> badness calculation on process/user/something basis.

I think what is really needed is a daemon to handle complex descisions
like that with the kernel OOM killer as a fall back.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

