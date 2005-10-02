Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVJBTE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVJBTE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 15:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVJBTE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 15:04:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751152AbVJBTE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 15:04:29 -0400
Date: Sun, 2 Oct 2005 12:04:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Coywolf Qi Hunt <coywolf@gmail.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCHv2] Document from line in patch format
In-Reply-To: <20051002163244.17502.15351.sendpatchset@jackhammer.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0510021158260.31407@g5.osdl.org>
References: <20051002163244.17502.15351.sendpatchset@jackhammer.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Oct 2005, Paul Jackson wrote:
>
> Document more details of patch format such as the "from" line
> used to specify the patch author, and provide more references
> for patch guidelines.

One more issue: I'd really prefer that the "---" not be documented as 
"optional".

Yes, my tools will also notice "diff -" and "Index: " at the start of the 
line as being markers for where the real patch starts, but that's a hack 
because people haven't been following the "---" rule. I'd much rather make 
it clear that the "---" is supposed to be there, to mark where the end of 
the comments are.

Note that after the "---" you can have any amount of explanations that are 
not to be committed as comments on why. Not just a "diffstat", but in 
general it's an area for explaining why I should commit it or random notes 
on the patch. Things that don't necessarily make sense once the patch _is_ 
committed.

For example, a submitter might want to note that he's working on a better 
patch, but that this patch is the minimal one before a release. Things he 
wants to tell the maintainer, but that don't necessarily make sense to 
anybody else.

So the _diffstat_ is optional (although much preferred, especially for 
bigger patches), but the marker of "this is the end of the comments for 
the changelog" is not.

		Linus
