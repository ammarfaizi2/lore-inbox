Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269863AbUJMVtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269863AbUJMVtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 17:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269866AbUJMVtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 17:49:18 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:52711 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269863AbUJMVtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 17:49:16 -0400
Subject: Re: 4level page tables for Linux II
From: Albert Cahalan <albert@users.sf.net>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041013092221.471f7232.ak@suse.de>
References: <1097638599.2673.9668.camel@cube>
	 <20041013092221.471f7232.ak@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1097703775.2673.10779.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Oct 2004 17:42:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 03:22, Andi Kleen wrote:
> On 12 Oct 2004 23:36:40 -0400
> Albert Cahalan <albert@users.sf.net> wrote:
> 
> > Hmmm...
> > 
> > pml4, pgd, pmd, pte  (kernel names)
> > PML4E, PDPE, PDE, PTE   (AMD hardware names)
> 
> No actually a PML4E is a PML4 _E_ntry in the AMD/Intel docs.
> PML4 is the official name for the fourth level page.
> 
> > It's kind of a mess, isn't it? It was bad enough
> > with the "pmd" (page middle directory, ugh) being
> > some random invention and everything being generally
> > in conflict with real hardware naming. Now you've
> > come up with a fourth name.
> > 
> > Notice that you've resorted to using a number.
> 
> I just followed AMD.
> 
> > Why not do that for the others too? It would
> > bring some order to this ever-growing collection
> > of arbitrary names. Like this:
> 
> I don't think it makes sense to break code unnecessarily.
> 
> And when you cannot remember the few names for the level you 
> better shouldn't touch VM at all.

One of the reasons that Linux is so hackable is that
crummy names get changed. Here too, the old names are bad.

An old example: we use copy_from_user now, not copy_fromfs.
Don't you agree that this is an improvement? It broke code
unnecessarily, but Linus did it anyway. Linux would be a
lot less readable if it had screwy names everywhere.

Perhaps you shouldn't touch kernel code if you can't
remember that copy_fromfs is unrelated to fs code.
Still, why make things difficult? The less effort you
waste remembering stupid names, the more you can spare
for writing great code.


