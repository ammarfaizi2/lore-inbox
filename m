Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSHOXi0>; Thu, 15 Aug 2002 19:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317779AbSHOXi0>; Thu, 15 Aug 2002 19:38:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317778AbSHOXiY>; Thu, 15 Aug 2002 19:38:24 -0400
Date: Thu, 15 Aug 2002 16:45:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208160003260.24255-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208151643380.15744-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Ingo Molnar wrote:
> 
> personally i'd make it even more compact by merging the two clone flags as
> well, something along: CLONE_MANAGE_TID. I cannot see any reason for a
> thread library to use one of the bits only.

A thread library - maybe not. But the SETTID thing makes sense even for a 
fork() user to avoid the fork/SIGCHLD race condition. In contrast, a 
CLRTID does _not_ make sense in that situation, so I actually think they 
are two separate issues (and should thus be two separate bits).

		Linus

