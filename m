Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281823AbRK1HMb>; Wed, 28 Nov 2001 02:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282029AbRK1HMV>; Wed, 28 Nov 2001 02:12:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39405 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281823AbRK1HMJ>;
	Wed, 28 Nov 2001 02:12:09 -0500
Date: Wed, 28 Nov 2001 10:09:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove BKL from llseek
In-Reply-To: <20011128141116.C22190@krispykreme>
Message-ID: <Pine.LNX.4.33.0111281009020.1845-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Nov 2001, Anton Blanchard wrote:

> The dbench-o-matic results from removing the BKL from llseek can be
> found here:
>
> http://samba.org/~anton/linux/llseek/
>
> Same hardware as the earlier test, 12 way ppc64. The patch is pretty
> dumb, I just pushed the kernel lock down into the llseek methods and
> only replaced it with the inode semaphore in generic_llseek. Im sure
> Al will have a better fix for 2.5, I just wanted to highlight the
> problem :)

yeah i did that once (about a year ago or more) and it was rejected, cant
remember why :-) But it's indeed an important optimization and it shows up
in dbench overhead.

	Ingo

