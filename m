Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268271AbUHXUWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268271AbUHXUWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUHXUWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:22:19 -0400
Received: from mail.dif.dk ([193.138.115.101]:17612 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268271AbUHXUTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:19:51 -0400
Date: Tue, 24 Aug 2004 22:25:26 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Josh Boyer <jdub@us.ibm.com>
Cc: Florian Weimer <fw@deneb.enyo.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
In-Reply-To: <1093378401.2991.32.camel@weaponx.rchland.ibm.com>
Message-ID: <Pine.LNX.4.61.0408242221030.2770@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> 
 <20040824184245.GE5414@waste.org>  <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
  <871xhwb9c6.fsf@deneb.enyo.de> <1093378401.2991.32.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Josh Boyer wrote:

> On Tue, 2004-08-24 at 14:54, Florian Weimer wrote:
> > * Linus Torvalds:
> > 
> > > On Tue, 24 Aug 2004, Matt Mackall wrote:
> > >> 
> > >> Phew, I was worried about that. Can I get a ruling on how you intend
> > >> to handle a x.y.z.1 to x.y.z.2 transition? I've got a tool that I'm
> > >> looking to unbreak. My preference would be for all x.y.z.n patches to
> > >> be relative to x.y.z.
> > >
> > > Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
> > > ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
> > > any ordering wrt the bugfixes), so either interdiffs or whole new full 
> > > diffs are totally "logical". We just have to chose one way or the other, 
> > > and I don't actually much care.
> > 
> > It would be slightly more consistent to diff .2 against .1 because
> > this is what already happens when a new x.y.z release is published.
> 
> Yes, but the -rcX releases aren't done that way.  It's mostly how you
> view things.  From a users point of view, do I want to download x.y.z
> and apply patches .1 through .N?  Or do I want to download x.y.z and
> apply 1 patch to get me to the x.y.z.N level?
> 
> Personally, I prefer the "one patch to rule them all" method. :)
> 
I agree, that would be my personal preference as well. Stick to what's 
currently done with the -rc, -mm etc patches - make x.y.z.2 be based on 
x.y.z, much easier on users. 
Also, the x.y.z.N patches are also most likely going to be pretty small 
even if diff'ed against x.y.z, so why burden the user with having to apply 
a series of patches?

--
Jesper Juhl

