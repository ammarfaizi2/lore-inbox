Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUIOVpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUIOVpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267601AbUIOVow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:44:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:43964 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267587AbUIOVlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:41:40 -0400
Date: Wed, 15 Sep 2004 14:45:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, wli@holomorphy.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-Id: <20040915144523.0fec2070.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
>
> William spotted this stray bit, LOCK_SECTION isn't used anymore on x86_64. 

btw, Ingo and I were scratching heads over an x86_64 oops in curent -linus
trees.

If you enable profiling and frame pointers, profile_pc() goes splat
dereferencing the `regs' argument when it decides that the pc refers to a
lock section.  Ingo said `regs' had a value of 0x2, iirc.  Consider this a
bug report ;)
