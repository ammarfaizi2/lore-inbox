Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263196AbTCYSRn>; Tue, 25 Mar 2003 13:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263174AbTCYSRn>; Tue, 25 Mar 2003 13:17:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:30024 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S263196AbTCYSRg>; Tue, 25 Mar 2003 13:17:36 -0500
Date: Tue, 25 Mar 2003 18:30:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: fix unuse_pmd() OOM handling
In-Reply-To: <20030325181313.GK30140@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0303251819060.10381-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, William Lee Irwin III wrote:
> On Tue, 25 Mar 2003, William Lee Irwin III wrote:
> >> Fix unuse_pmd() OOM handling for pte_chain_alloc() failures.
> >> Unfortunately I'm not able to trigger anything more than light
> >> swapping loads to test this with.
> 
> On Tue, Mar 25, 2003 at 06:04:09PM +0000, Hugh Dickins wrote:
> > Sorry, Bill: please ignore this one, Andrew: I'm preparing a
> > better patch for this, extracted from my anobjrmap patches.
> 
> This stuff was relatively brutally crowbarred in. Go ahead and
> send it in, I'd actually rather have rmap_get_cpu() than this.

So would I!  but I'm afraid I've done this the pte_chainp way too.
rmap_get_cpu() becomes attractive when you know that you nowhere
need more than one per cpu per locking, as in anobjrmap where
copy_page_range needs none at all; but I don't see much point in
trying to backport it to mainline/-mm without that assurance.

Hugh

