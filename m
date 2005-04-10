Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVDJRAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVDJRAf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVDJRAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:00:35 -0400
Received: from wingding.demon.nl ([82.161.27.36]:13201 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S261521AbVDJRAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:00:10 -0400
Date: Sun, 10 Apr 2005 19:00:04 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
Message-ID: <20050410170004.GA20256@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
Organization: M38c
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 08:44:56AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 10 Apr 2005, Junio C Hamano wrote:
> > 
> > But I am wondering what your plans are to handle renames---or
> > does git already represent them?
> 
> You can represent renames on top of git - git itself really doesn't care.  
> In many ways you can just see git as a filesystem - it's content-
> addressable, and it has a notion of versioning, but I really really
> designed it coming at the problem from the viewpoint of a _filesystem_
> person (hey, kernels is what I do), and I actually have absolutely _zero_
> interest in creating a traditional SCM system.
> 
> So to take renaming a file as an example - why do you actually want to 
> track renames? In traditional SCM's, you do it for two reasons:
> 
>  - space efficiency. Most SCM's are based on describing changes to a file, 
[snip]
>  - annotate/blame. This is a valid concern, but the fact is, I never use 
[snip]

- merging.
  When the parent tree renames a file, it's easier for an out-of-tree
  patch to get up-to-date.

- reviewing.
  A huge patch with 2000 added lines and 1990 removed lines is more
  difficult to review then a rename + 10 lines patch.

> So consider me deficient, or consider me radical. It boils down to the 
> same thing. Renames don't matter. 

When you've got no out-of-tree patches since you've got the
parent-of-all-trees, then they don't matter, that's true :)

> So whether you agree with the things that _I_ consider important probably
> depends on how you work. The real downside of GIT may be that _my_ way of 
> doing things is quite possibly very rare.


-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
