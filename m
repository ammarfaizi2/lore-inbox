Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269641AbUJMHXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269641AbUJMHXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 03:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269643AbUJMHXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 03:23:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:48804 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269641AbUJMHXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 03:23:19 -0400
Date: Wed, 13 Oct 2004 09:22:21 +0200
From: Andi Kleen <ak@suse.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4level page tables for Linux II
Message-Id: <20041013092221.471f7232.ak@suse.de>
In-Reply-To: <1097638599.2673.9668.camel@cube>
References: <1097638599.2673.9668.camel@cube>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Oct 2004 23:36:40 -0400
Albert Cahalan <albert@users.sf.net> wrote:

> Hmmm...
> 
> pml4, pgd, pmd, pte  (kernel names)
> PML4E, PDPE, PDE, PTE   (AMD hardware names)

No actually a PML4E is a PML4 _E_ntry in the AMD/Intel docs.
PML4 is the official name for the fourth level page.

> It's kind of a mess, isn't it? It was bad enough
> with the "pmd" (page middle directory, ugh) being
> some random invention and everything being generally
> in conflict with real hardware naming. Now you've
> come up with a fourth name.
> 
> Notice that you've resorted to using a number.

I just followed AMD.

> Why not do that for the others too? It would
> bring some order to this ever-growing collection
> of arbitrary names. Like this:

I don't think it makes sense to break code unnecessarily.

And when you cannot remember the few names for the level you 
better shouldn't touch VM at all.

-Andi
