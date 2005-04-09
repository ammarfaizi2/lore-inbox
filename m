Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVDIA1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVDIA1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 20:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVDIA1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 20:27:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:43950 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261218AbVDIA1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 20:27:35 -0400
Date: Fri, 8 Apr 2005 17:29:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <Pine.LNX.4.58.0504081613180.28951@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0504081718570.28951@ppc970.osdl.org>
References: <4257055A.7010908@umich.edu> <Pine.LNX.4.58.0504081613180.28951@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Linus Torvalds wrote:
> 
> Also note that the above algorithm really works for _any_ two commit 
> points (apart for the two first steps, which are obviously all about 
> finding the parent tree when you want to diff against a predecessor). 

Btw, if you want to try this, you should get an updated copy. I've pushed 
a "raw" git archive of both git and sparse (the latter is much more 
interesting from an archive standpoint, since it actually has 1400 
changesets in it) to kernel.org, but I'm not convinced it gets mirrored 
out. I think the mirror scripts may mirror only things they understand.

I've also added a partial "fsck" for the "git filesystem". It doesn't do
the connectivity analysis yet, but that should be pretty straightforward
to add - it already parses all the data, it just doesn't save it away (and
the connectivity analysis will automatically show how many "root"
changesets you have, and what the different HEADs are).

I'll make a tar-file (git-0.03), although at this point I've actually been 
maintaining it in itself, so to some degree it's almost getting easier if 
I'd just have a place to rsync it..

		Linus
