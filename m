Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279658AbRJ3AGA>; Mon, 29 Oct 2001 19:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279653AbRJ3AFn>; Mon, 29 Oct 2001 19:05:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24839 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279674AbRJ3AFZ>; Mon, 29 Oct 2001 19:05:25 -0500
Date: Mon, 29 Oct 2001 16:04:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, "David S. Miller" <davem@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <Pine.LNX.4.21.0110292358290.1036-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0110291603330.16744-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Hugh Dickins wrote:
>
> But was the original flush_tlb_page() fully correct?  In i386 it's
> 	if (vma->vm_mm == current->active_mm)
> 		__flush_tlb_one(addr);
> without reference to whether vma->vm_mm is active on another cpu.

No, you're looking at the UP inline version - the SMP version is
elsewhere.

		Linus

