Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313927AbSDXGlg>; Wed, 24 Apr 2002 02:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314179AbSDXGlf>; Wed, 24 Apr 2002 02:41:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43536 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313927AbSDXGlf>; Wed, 24 Apr 2002 02:41:35 -0400
Date: Tue, 23 Apr 2002 23:40:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 next sync for 2.5.9
In-Reply-To: <20020423215419.A7734@averell>
Message-ID: <Pine.LNX.4.44.0204232338200.18086-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Apr 2002, Andi Kleen wrote:
>
> - implement early_printk properly as an registered console. this requires
> an addition to init/main.c to disable the early console before the
> real console is initialized. Also add early serial console support while
> I was at it.

That init/main.c hackery needs to go away - this should all be totally
internal to the console layer, and there is no reason why init/main.c
should be involved at all.

		Linus

