Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287348AbSA2XkY>; Tue, 29 Jan 2002 18:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287254AbSA2Xi6>; Tue, 29 Jan 2002 18:38:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13828 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287109AbSA2Xhu>; Tue, 29 Jan 2002 18:37:50 -0500
Date: Tue, 29 Jan 2002 15:36:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
In-Reply-To: <Pine.LNX.4.44.0201291713090.25443-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0201291535120.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Oliver Xymoron wrote:
>
> Seems like we could do slightly better to have these local areas mapped to
> the same virtual address on each processor, which does away with the need
> for an entire level of indirection.

No no no.

That is a really stupid idea, even though every single OS developer has at
some time thought that it was the great idea (and it shows up in a lot of
OS's).

The reason it is a stupid idea is that if you do it, you can no longer
share page tables between CPU's (unless all CPU's you support have TLB
fill in software).

		Linus

