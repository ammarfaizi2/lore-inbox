Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbTBJW0g>; Mon, 10 Feb 2003 17:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbTBJW0f>; Mon, 10 Feb 2003 17:26:35 -0500
Received: from ns.suse.de ([213.95.15.193]:49681 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265484AbTBJW00>;
	Mon, 10 Feb 2003 17:26:26 -0500
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon adv speculative caching fix removed from 2.4.20?
References: <200302102321.30549.kiza@gmx.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Feb 2003 23:36:12 +0100
In-Reply-To: Oliver Feiler's message of "10 Feb 2003 23:23:18 +0100"
Message-ID: <p73fzqvbw6b.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Feiler <kiza@gmx.net> writes:
> 
> Can someone point to a why this was removed, maybe a different fix since the 
> one mentioned says "Short-term fix" or is it not needed anymore for some 
> reason?

The "long term" fix for it went in instead (arch/i386/mm/pageattr.c)
The kernel is careful now to not create conflicting cache attributes
for AGP and other mappings.  This makes the linux kernel x86
conformant in this area.  It also increases performance on
Athlon XP/MP because they can now use large pages in kernel space again.

-Andi
