Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280415AbRKJBLh>; Fri, 9 Nov 2001 20:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280372AbRKJBL1>; Fri, 9 Nov 2001 20:11:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59366 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280415AbRKJBLM>;
	Fri, 9 Nov 2001 20:11:12 -0500
Date: Fri, 9 Nov 2001 20:11:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] long-living cache for block devices
In-Reply-To: <Pine.LNX.4.33.0111091700230.1350-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111092010150.12727-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Nov 2001, Linus Torvalds wrote:

> 
> On Fri, 9 Nov 2001, Alexander Viro wrote:
> >
> > 	Logics looks so: upon the final close() we finish all pending
> > IO and destroy all buffer_heads for device.
> 
> Why do yu care about destroying buffer-heads?
> 
> You might as well leave them active, I don't see what you win from trying
> to get rid of them aggressively. They'll go away when the pages go away..

The simplest way to make sure that all IO is over (including readaheads).

