Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbUJXWjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUJXWjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 18:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUJXWjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 18:39:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59068 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261608AbUJXWi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 18:38:56 -0400
Date: Mon, 25 Oct 2004 00:33:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.58.0410241027320.13209@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410242126000.17266@scrub.home>
References: <41752E53.8060103@pobox.com>  <20041019153126.GG18939@work.bitmover.com>
  <41753B99.5090003@pobox.com>  <4d8e3fd304101914332979f86a@mail.gmail.com>
  <20041019213803.GA6994@havoc.gtf.org>  <4d8e3fd3041019145469f03527@mail.gmail.com>
  <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>  <20041023161253.GA17537@work.bitmover.com>
 <4d8e3fd304102403241e5a69a5@mail.gmail.com> <Pine.LNX.4.58.0410241027320.13209@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 24 Oct 2004, Linus Torvalds wrote:

>  - I do _not_ want people to "own" subsystems. And that's not so much an 
>    anti-maintainer issue (I _love_ maintainers), as more of a "conceptual" 
>    issue. When people expect one person or one group of person to be the 
>    only way to touch a certain subsystem, we have problems. I really 
>    really want everybody (users, developers _and_ maintainers) to realize 
>    that no code is an island, and work with other people touching their 
>    subsystem.

OTOH people often just send patches directly to you without bothering to 
contact the maintainer. There is no system that sends out notifications, 
if a patch touches file x/y, so that one has a chance to comment on them.
To be very clear on this, I don't want to control what goes in, I'd just 
like to know about changes _before_ they go in.

>    So BK helps this model, because the distributed nature of BK means that 
>    you can have several pseudo-official trees _and_ totally unofficial
>    ones, and merging is automatic and basically impossible to avoid, so 
>    the "official" tree never gets to drown out the unofficial work. But 
>    despite that, I want to make people _aware_ that maintainership does
>    not imply total ownership, and that we don't have a "hierarchy" of 
>    developers but a *network* of developers.

One should also add that bk is not the answer to everything, e.g. bk 
doesn't really help with maintaining separate patches. As one cannot 
remove or change information from/in bk, that makes it difficult to 
work on a series of patches, e.g. as Andrew does with -mm, a tool like 
quilt is more helpful here.
This means patches should only be put into bk, when they are ready 
(otherwise the repo accumulates useless info nobody is really interested 
in), during their development bk is about as useful as any other SCM 
system. bk simplifies mainly your work, but the further one is away from 
the core of this developer network, the more bk looses its advantage 
(and might only increase the amount of merge information bk has to 
manage in relation to patch information).

bye, Roman
