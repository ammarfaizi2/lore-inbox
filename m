Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWGKWUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWGKWUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWGKWUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:20:52 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:14011 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932201AbWGKWUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:20:51 -0400
Date: Wed, 12 Jul 2006 00:20:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>,
       hch@infradead.org, dwmw2@infradead.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711222032.GC21448@wohnheim.fh-wedel.de>
References: <20060711160639.GY13938@stusta.de> <1152635323.3373.211.camel@pmac.infradead.org> <20060711173301.GA27818@infradead.org> <20060711193423.GA9685@mars.ravnborg.org> <20060711194107.GA10733@mars.ravnborg.org> <20060711134106.18f6dd2e.rdunlap@xenotime.net> <20060711213733.GB21448@wohnheim.fh-wedel.de> <44B41FB1.7050704@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44B41FB1.7050704@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 July 2006 15:01:21 -0700, H. Peter Anvin wrote:
> Jörn Engel wrote:
> >
> >Not too bad in principle, but there were two problems I couldn't
> >solve:
> >1. One of the goals should be to make a compile faster, not slower.
> >Adding further includes hardly helps.
> >2. It is practically impossible to test every possible combination of
> >#ifdefs in the various headers pulled in.
> >
> 
> #1 I doubt the time taken to look at include files that are #ifndef'd in 
> their entirety is significant (I think there is special code in gcc to 
> handle this case fast.)

Quoting Dave Jones from a few mails down the thread:
It did make a noticable difference to compiles, though I forget the
exact numbers.   Should be in the list archives somewhere.
I have vague recollection that it shaved off around 20-30s, though
my memory is fuzzy.

> #2 is actually a non-issue.  If each file is usable standalone (and have 
> a multiple inclusion guard), then the include order shouldn't matter. 
> Not that one can't create contrived cases where it would matter, but one 
> can't solve every problem...

#2 was not about include order, but about things like CONFIG_SMP,
different arches, etc.  As Russell King showed, breaking Arm is easier
than many people think.

Jörn

-- 
Don't patch bad code, rewrite it.
-- Kernigham and Pike, according to Rusty
