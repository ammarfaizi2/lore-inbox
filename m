Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282769AbRLGGJd>; Fri, 7 Dec 2001 01:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282771AbRLGGJ1>; Fri, 7 Dec 2001 01:09:27 -0500
Received: from www.wen-online.de ([212.223.88.39]:18706 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S285424AbRLGGJQ>;
	Fri, 7 Dec 2001 01:09:16 -0500
Date: Fri, 7 Dec 2001 07:11:29 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73r8q86lpn.fsf@amdsim2.suse.de>
Message-ID: <Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Dec 2001, Andi Kleen wrote:

> Andrew Morton <akpm@zip.com.au> writes:
> >
> > The fact that you get the same throughput on each platform with
> > the block I/O part of the test indicates that the hardware and
> > kernel are OK, but the C library is broken.
>
> The usual difference is if you have a pthreads capable C library
> or not. For newer glibc bonnie++ should definitely use
> putc_unlocked(); otherwise it'll eat lock overhead for each character
> to take the FILE lock.
>
> As far as I can see bonnie++ doesn't use putc_unlocked, but putc.

Plain old Bonnie suffered from the same thing.  I long ago made it
use putc_unlocked() here because throughput was horrible otherwise.

	-Mike

