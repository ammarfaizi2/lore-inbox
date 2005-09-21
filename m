Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVIUQuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVIUQuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVIUQuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:50:32 -0400
Received: from silver.veritas.com ([143.127.12.111]:33286 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751150AbVIUQub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:50:31 -0400
Date: Wed, 21 Sep 2005 17:50:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Blaisorblade <blaisorblade@yahoo.it>
cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Remap_file_pages, RSS limits, security implications (was: Re:
 [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection support (for
 UML), try 3)
In-Reply-To: <200509211816.37512.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0509211729020.8121@goblin.wat.veritas.com>
References: <200508262023.29170.blaisorblade@yahoo.it>
 <200509201706.06852.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509211547270.6584@goblin.wat.veritas.com>
 <200509211816.37512.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 16:50:30.0520 (UTC) FILETIME=[9361E780:01C5BECC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Blaisorblade wrote:
> 
> Other pages in the VMA may be unmapped, yes, but not freed. In fact, they're 
> kept in by the pagecache reference; try_to_unmap() (or better its caller, 
> shrink_list) will only actually free the page it asked for.

Not freed in that pass, yes; but brought closer to being freed soon.

> The only real "problem" is that we do ptep_clear_flush_young without 
> activating the page. And yes, *this* may penalize who holds a nonlinear VMA. 
> But this is probably fair, given that we're going to have trouble in freeing 
> those pages.

Good point, I don't remember ever considering that.
But agree it should work out fairly.

> > mm/trash.c?  I got quite excited,
> What would that have meant?

Trash is rubbish or garbage.  Or if I trash my hotel room (not me!),
I'd rip the washbasin off the wall, smash the mirror, throw the
chair through the window, ... hmm, better stop this public fantasy.

Hugh
