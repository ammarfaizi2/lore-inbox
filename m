Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280670AbRKSTxi>; Mon, 19 Nov 2001 14:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280676AbRKSTxZ>; Mon, 19 Nov 2001 14:53:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14096 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280670AbRKSTxC>; Mon, 19 Nov 2001 14:53:02 -0500
Date: Mon, 19 Nov 2001 11:48:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] problem with grow_dev_page()/readpage()
In-Reply-To: <Pine.GSO.4.21.0111191435090.19969-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111191147040.8447-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Alexander Viro wrote:
>
> 	Look at block_read_full_page().  If it sees ->buffers != NULL, it
> assumes that buffer size corresponds to ->i_blkbits.

It doesn't matter - it doesn't _use_ the thing, if the buffers are mapped
(and they will always be mapped for block devices).

So it only cares about i_blkbits if it creates new buffers.

		Linus

