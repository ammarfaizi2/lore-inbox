Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUAJGGh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 01:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUAJGGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 01:06:37 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:32004 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264902AbUAJGGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 01:06:35 -0500
Date: Sat, 10 Jan 2004 14:05:37 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: "H. Peter Anvin" <hpa@zytor.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <3FFF1499.7030508@sun.com>
Message-ID: <Pine.LNX.4.33.0401101358290.2403-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.5, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Mike Waychison wrote:

> >
> >This may sound a little silly but it may be able to be done using
> >stackable filesystem methods (aka. Zadok et. al.). I'm thinking of an
> >autofs filesystem stacked on a host filesystem. The dentrys corresponding
> >to mount points marked in some way and the mount occuring under it, on top
> >of the host filesystem. Yes I know it sounds ugly but maybe it's not.
> >Maybe it's actually quite simple. I can't give an opinion yet as I'm still
> >thinking it through and haven't done any feasibility. However, this
> >approach would lend itself to providing autofs filesystem transparency. A
> >requirement as yet not discussed.
> >
> >Ian
> >
> >
> >
> Doing stackable filesystems is still an area of OS research.  It turns
> out to be a very hard problem to solve (if it's possible at all).
> Although there are systems in the wild that appear to work, they are
> usually sub-optimal because there remains alot of issues such as
> maintaining coherent caches, as well as just staying coherent given that
> one filesystem may be directly accessible while also accessed from
> another overlayed filesystem.

Yes I see that in what I've read.

But I'm thinking of a very tightly controlled autofs layer controlled
only by automount. Once owned by automount that part of the underlying fs
could only be accessed via automount. The boundry cases obviously are
a sensitive area.

>
> Not really something you'd want to waste alot of time on unless your
> looking for a phd thesis. ;)

A masters one day might be good.

Ian



