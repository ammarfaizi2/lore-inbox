Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284491AbRLMSBT>; Thu, 13 Dec 2001 13:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284500AbRLMSBK>; Thu, 13 Dec 2001 13:01:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:42411 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S284491AbRLMSA6>; Thu, 13 Dec 2001 13:00:58 -0500
Date: Thu, 13 Dec 2001 18:02:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
In-Reply-To: <Pine.LNX.4.33.0112130920260.19658-100000@mf1.private>
Message-ID: <Pine.LNX.4.21.0112131745580.1594-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Wayne Whitney wrote:
> On Thu, 13 Dec 2001, Hugh Dickins wrote:
> 
> > My fear is that you may encounter an indefinite number of buggy apps,
> > which expect an mmap() to follow the mmap() before: easy bug to
> > commit, and to go unnoticed, until you reverse the layout.
> 
> Hmm, so which is more important to support, buggy users of (unguaranteed
> side effects of) the new interface, or users of the legacy interface?  I
> can see the argument that that the buggy users of the new interface are
> more important.  Maybe CONFIG_MMAP_GROWS_DOWNWARDS, or a /proc entry?

Hard to know until you try it: my fear may prove groundless,
or experience may discourage you from the exercise completely.

Quick guess is that what you'd really want in the end is not a
CONFIG option or /proc tunable, but some mark in an ELF section
for what behaviour that particular executable wants.

I'm reluctant to call wanting a large virtual address space buggy;
but expecting contiguous ascending mmaps (without MAP_FIXED) is buggy.

Hugh

