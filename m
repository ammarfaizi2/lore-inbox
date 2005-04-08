Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVDHRpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVDHRpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbVDHRpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:45:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:10922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261834AbVDHRou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:44:50 -0400
Date: Fri, 8 Apr 2005 10:46:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050408171518.GA4201@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
 <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <20050408171518.GA4201@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Chris Wedgwood wrote:
> On Fri, Apr 08, 2005 at 10:14:22AM -0700, Linus Torvalds wrote:
> 
> > After applying a patch, I can do a complete "show-diff" on the kernel tree
> > to see the effect of it in about 0.15 seconds.
> 
> How does that work?  Can you stat the entire tree in that time?  I
> measure it as being higher than that.

I can indeed stat the entire tree in that time (assuming it's in memory,
of course, but my kernel trees are _always_ in memory ;), but in order to
do so, I have to be good at finding the names to stat.

In particular, you have to be extremely careful. You need to make sure 
that you don't stat anything you don't need to. We're not talking just 
blindly recursing the tree here, and that's exactly the point. You have to 
know what you're doing, but the whole point of keeping track of directory 
contents is that dammit, that's your whole job.

Anybody who can't list the files they work on _instantly_ is doing 
something damn wrong. 

"git" is really trivial, written in four days. Most of that was not 
actually spent coding, but thinking about the data structures.

			Linus


