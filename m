Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUIOV5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUIOV5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUIOV4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:56:44 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:23761 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267646AbUIOVzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:55:31 -0400
Date: Wed, 15 Sep 2004 17:55:30 +0000 (UTC)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
In-Reply-To: <20040915144523.0fec2070.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0409151751140.19505@musoma.fsmlabs.com>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com>
 <20040915144523.0fec2070.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
> >
> > William spotted this stray bit, LOCK_SECTION isn't used anymore on x86_64. 
> 
> btw, Ingo and I were scratching heads over an x86_64 oops in curent -linus
> trees.
> 
> If you enable profiling and frame pointers, profile_pc() goes splat
> dereferencing the `regs' argument when it decides that the pc refers to a
> lock section.  Ingo said `regs' had a value of 0x2, iirc.  Consider this a
> bug report ;)

Yeah profile_pc on x86_64 is just broken, i'll have a look.

Thanks,
	Zwane

