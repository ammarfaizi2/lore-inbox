Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSGVNqV>; Mon, 22 Jul 2002 09:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSGVNpy>; Mon, 22 Jul 2002 09:45:54 -0400
Received: from verein.lst.de ([212.34.181.86]:14604 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S317253AbSGVNn5>;
	Mon, 22 Jul 2002 09:43:57 -0400
Date: Mon, 22 Jul 2002 15:46:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
Message-ID: <20020722154656.A19039@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <20020722152056.A18619@lst.de> <Pine.LNX.4.44.0207221538580.9004-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207221538580.9004-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jul 22, 2002 at 03:43:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 03:43:50PM +0200, Ingo Molnar wrote:
> i'm not so sure about flags_t. 'unsigned long' worked pretty well so far,
> and i do not see the need for a more complex (or more opaque) irqflags
> type. It's not that we confuse flags with some other flag all that
> frequently that would necessiate some structure-based more abstract
> protection of these variables.

It's just that we don't really care what it is.  But the type change
wasn't my main point, rather the returning of the flags value in
irq_save to allow implementing it as non-macro.

