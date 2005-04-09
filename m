Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVDIBAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVDIBAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVDIBAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:00:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29100 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261223AbVDIBAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:00:37 -0400
Date: Sat, 9 Apr 2005 03:00:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tupshin Harper <tupshin@tupshin.com>
cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <425717CB.6020405@tupshin.com>
Message-ID: <Pine.LNX.4.61.0504090242531.15339@scrub.home>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <1112858331.6924.17.camel@localhost.localdomain>
 <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
 <Pine.LNX.4.61.0504072318010.15339@scrub.home> <425717CB.6020405@tupshin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Apr 2005, Tupshin Harper wrote:

> > 	A1 -> A2 -> A3 -> B1 -> B2
> > 
> > This results in a simpler repository, which is more scalable and which is
> > easier for users to work with (e.g. binary bug search).
> > The disadvantage would be it will cause more minor conflicts, when changes
> > are pulled back into the original tree, but which should be easily
> > resolvable most of the time.
> > 
> Both darcs and arch (and arch's siblings) have ways of maintaining the
> complete history but speeding up operations.

Please show me how you would do a binary search with arch.

I don't really like the arch model, it's far too restrictive and it's 
jumping through hoops to get to an acceptable speed.
What I expect from a SCM is that it maintains both a version index of the 
directory structure and a version index of the individual files. Arch 
makes it especially painful to extract this data quickly. For the common 
cases it throws disk space at the problem and does a lot of caching, but 
there are still enough problems (e.g. annotate), which require scanning of 
lots of tarballs.

bye, Roman
