Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVI1Nhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVI1Nhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVI1Nhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:37:55 -0400
Received: from gold.veritas.com ([143.127.12.110]:4914 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750962AbVI1Nhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:37:54 -0400
Date: Wed, 28 Sep 2005 14:37:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Blaisorblade <blaisorblade@yahoo.it>
cc: LKML <linux-kernel@vger.kernel.org>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection
 support (for UML), try 3
In-Reply-To: <200509261758.23705.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0509281418500.6830@goblin.wat.veritas.com>
References: <200508262023.29170.blaisorblade@yahoo.it>
 <200509042110.01968.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
 <200509261758.23705.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Sep 2005 13:37:53.0938 (UTC) FILETIME=[D403AF20:01C5C431]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, it's really hard to read your interspersed comments.  Perhaps I
need to switch on some colour option when reading your mails, but I've
never found the need for it before.  Please, use a blank line above
and below your comments to help us locate them and read them, thanks.

On Mon, 26 Sep 2005, Blaisorblade wrote:
> On Wednesday 07 September 2005 14:00, Hugh Dickins wrote:
> 
> > So far as I can see (I may have missed it), you really don't need to
> > change from the write boolean
> 
> > (perhaps -1 for exec in one arch??)
> ? Not understood this part, ignoring it?
> Maybe you mean "except one arch, x86_64, which supports exec protection?"

No, I meant the current code uses "0" for read fault, "1" for write fault,
and (in a quick search) only found one architecture (I forget which,
certainly not x86_64) which might have been interested to pass down
a different value to handle_mm_fault to distinguish execution fault:
for which I was suggesting to use "-1", rather than change everywhere.
Though now I'm doubting there was any such case at all.

Hugh
