Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280364AbRKJBHr>; Fri, 9 Nov 2001 20:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280365AbRKJBHh>; Fri, 9 Nov 2001 20:07:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36619 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280364AbRKJBH0>; Fri, 9 Nov 2001 20:07:26 -0500
Date: Fri, 9 Nov 2001 17:03:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] long-living cache for block devices
In-Reply-To: <Pine.GSO.4.21.0111091903220.12581-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111091700230.1350-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Nov 2001, Alexander Viro wrote:
>
> 	Logics looks so: upon the final close() we finish all pending
> IO and destroy all buffer_heads for device.

Why do yu care about destroying buffer-heads?

You might as well leave them active, I don't see what you win from trying
to get rid of them aggressively. They'll go away when the pages go away..

		Linus

