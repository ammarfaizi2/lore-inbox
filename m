Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135702AbRDSUuJ>; Thu, 19 Apr 2001 16:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135704AbRDSUuA>; Thu, 19 Apr 2001 16:50:00 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44038 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135702AbRDSUtr>; Thu, 19 Apr 2001 16:49:47 -0400
Date: Thu, 19 Apr 2001 13:49:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@cygnus.com>
cc: Alexander Viro <viro@math.psu.edu>,
        Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <m3ofts3d4k.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.4.31.0104191347480.1182-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 19 Apr 2001, Ulrich Drepper wrote:

> Linus Torvalds <torvalds@transmeta.com> writes:
>
> > Looks good to me. Anybody want to try this out and test some benchmarks?
>
> I fail to see how this works across processes.

It's up to FS_create() to create whatever shared mapping is needed.

For threads, you don't need anything special.

For fork()'d helper stuff, you'd use MAP_ANON | MAP_SHARED.

For execve(), you need shm shared memory or MAP_SHARED on a file.

It all depends on your needs.

		Linus

