Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVCJEHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVCJEHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVCJEEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:04:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:20421 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262652AbVCJAom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:44:42 -0500
Subject: Re: [PATCH 0/15] ptwalk: pagetable walker cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 11:39:44 +1100
Message-Id: <1110415184.32524.128.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 22:05 +0000, Hugh Dickins wrote:
> Here's a cleanup of the pagetable walkers, in common and i386 code,
> based on 2.6.11-bk5.  Mainly to make them all go the same simpler way,
> so they're easier to follow with less room for error; but also to reduce
> the code size and speed it up a little.  These are janitorial changes,
> other arches may follow whenever it suits them.
>
> .../...

Do you have them on HTTP somewhere ? Apparently, a few of the 15 patches
didn't make it to me.

There are some other bugs introduced by set_pte_at() caused by latent
bugs in the PTE walkers that 'drop' part of the address along the way,
notably the vmalloc.c ones are bogus, thus breaking ppc/ppc64 in subtle
ways. Before I send patches, I'd rather check if it's not all fixed by
your patches first :)

Ben.


