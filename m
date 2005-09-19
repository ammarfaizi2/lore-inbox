Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbVISVbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbVISVbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVISVbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:31:17 -0400
Received: from silver.veritas.com ([143.127.12.111]:53551 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932703AbVISVbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:31:16 -0400
Date: Mon, 19 Sep 2005 22:30:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Smarduch Mario-CMS063 <CMS063@motorola.com>, linux-kernel@vger.kernel.org
Subject: Re: Multi-Threaded fork() correctness on Linux 2.4 & 2.6
In-Reply-To: <Pine.LNX.4.58.0509191327160.2553@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0509192227530.26271@goblin.wat.veritas.com>
References: <A752C16E6296D711942200065BFCB6942521C43A@il02exm10>
 <Pine.LNX.4.61.0509191928080.23718@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0509191216050.2553@g5.osdl.org>
 <Pine.LNX.4.61.0509192106460.25004@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0509191327160.2553@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Sep 2005 21:31:13.0680 (UTC) FILETIME=[75DCA900:01C5BD61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, Linus Torvalds wrote:
> 
> Hmm. But we do hold the mmap_sem for writing, and we flush before we 
> release it, so it should still be ok. The page fault case needs to get it 
> for reading anyway.
> 
> Yeah, the page_table_lock might make more sense, but I think the mmap_sem 
> thing works equally well.

Yes, you're both ahead of me: thank you for working that out: no issue.

Hugh
