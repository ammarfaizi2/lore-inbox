Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTJAOtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTJAOtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:49:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34963 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262427AbTJAOta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:49:30 -0400
Date: Wed, 1 Oct 2003 15:49:29 +0100
From: Matthew Wilcox <willy@debian.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Valdis.Kletnieks@vt.edu, Dave Jones <davej@redhat.com>,
       Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful
Message-ID: <20031001144929.GP24824@parcelfarce.linux.theplanet.co.uk>
References: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk> <20031001141950.GA13115@redhat.com> <200310011429.h91ETtcG009923@turing-police.cc.vt.edu> <20031001144223.GJ31698@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031001144223.GJ31698@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 04:42:23PM +0200, Jörn Engel wrote:
> On Wed, 1 October 2003 10:29:55 -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 01 Oct 2003 15:19:52 BST, Dave Jones said:
> > 
> > > Maybe it should be taught to parse comments? There are zillions of
> > > #endif /* CONFIG_FOO */
> > > braces in the tree. Why is this one special ?
> > 
> > I think it's because it looked like:
> > 
> > #ifdef CONFIG_FOO
> > ....
> > #endif /* CONFIG_FOO or CONFIG_BAR */
> > 
> > and it concluded there was a dependency on BAR.
> 
> Or rather like this:
> 
> #ifdef CONFIG_FOO
> ...
> #endif /* CONFIG_FO */
> 
> Problem is that we humans correct the type before it even reaches our
> conciousness.  Machines don't do that yet.

But it used to look like

#ifdef BAR || BAZ
...
#endif /* BAR || BAZ */

now it looks like

#ifdef BAZ
...
#endif /* BAR || BAZ */

if you can't trust people to keep comments up to date, delete the comments.
No comments are better than wrong comments.

Remember the classic?

/* Keep these two variables together */
int bar;

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
