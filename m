Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbSA2XhZ>; Tue, 29 Jan 2002 18:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287163AbSA2Xf6>; Tue, 29 Jan 2002 18:35:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33811 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286647AbSA2Xed>; Tue, 29 Jan 2002 18:34:33 -0500
Date: Tue, 29 Jan 2002 15:33:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Momchil Velikov <velco@fadata.bg>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <877kq04v7w.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Jan 2002, Momchil Velikov wrote:
>
> rat-7 is with 128-way radix tree branch factor, rat-4 is with 16-way.

Hmm. It appears that the 128-way one is no slower, at least.

Probably not very relevant question: What are the memory usage
implications? I love having that global big page_hash_table gone, but what
are the differences in memory usage between rat-4 and rat-7? In
particular, it _looks_ like the way the radix_node is done, it will
basically always be a factor-of-two+1 words, which sounds like the worst
possible schenario from an allocator standpoint.

		Linus

