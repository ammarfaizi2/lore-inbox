Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277188AbRKFFwK>; Tue, 6 Nov 2001 00:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277842AbRKFFvv>; Tue, 6 Nov 2001 00:51:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55819 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277094AbRKFFvj>; Tue, 6 Nov 2001 00:51:39 -0500
Date: Mon, 5 Nov 2001 21:48:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <3BE77599.9CFB5CA9@zip.com.au>
Message-ID: <Pine.LNX.4.33.0111052141100.1480-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Nov 2001, Andrew Morton wrote:
>
> I didn't understand your objection to the heuristic "was the
> parent directory created within the past 30 seconds?". If the
> parent and child were created at the same time, chances are that
> they'll be accessed at the same time?

the thing I don't like about it is the non-data-dependence, ie the
layout of the disk will actually depend on how long it took you to write
the tree.

I'm not saying it's a bad heuristic - it's probably a fine (and certainly
simple) one. But the thought that when the NFS server has problems, a
straight "cp -a" of the same tree results in different layout just because
the server was moved over from one network to another makes me go "Ewww.."

		Linus

