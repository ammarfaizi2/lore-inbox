Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSGVNv2>; Mon, 22 Jul 2002 09:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317360AbSGVNvB>; Mon, 22 Jul 2002 09:51:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8672 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317354AbSGVNuq>;
	Mon, 22 Jul 2002 09:50:46 -0400
Date: Mon, 22 Jul 2002 15:52:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <20020722154656.A19039@lst.de>
Message-ID: <Pine.LNX.4.44.0207221550470.9345-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we abstracted simple types such as pte_t, pmd_t and pgd_t for one good
reason: it's 3 *distinct* entities that can be confused quite easily,
causing subtle VM bugs (eg. for quite some time the x86 arch had 2-level
paging only, so to have a proper 3-level paging VM we needed these type
checks).

i dont sense the same type of urge (and danger of mixup) wrt. the
interrupt flags.

	Ingo

