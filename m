Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311264AbSCQCKo>; Sat, 16 Mar 2002 21:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311265AbSCQCKe>; Sat, 16 Mar 2002 21:10:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63760 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311264AbSCQCK1>; Sat, 16 Mar 2002 21:10:27 -0500
Date: Sat, 16 Mar 2002 18:08:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <15507.60617.911732.176262@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0203161804210.1505-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Mar 2002, Paul Mackerras wrote:
> 
> In particular I think it would help if set_pte could be given the
> mm_struct and the virtual address, then set_pte could fairly easily
> invalidate the hash-table entry (if any) corresponding to the PTE
> being changed.  Would you consider a patch along these lines?

How about just doing a few more "update_mmu_cache()" type of things?

This is actually why update_mmu_cache() exists in the first place - to be 
able to proactively fill in shadow information like hashed page tables.

Adding a "clear_mmu_cache()"?

		Linus

