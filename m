Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbTKULkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 06:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbTKULkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 06:40:51 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:48796 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S264359AbTKULku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 06:40:50 -0500
Date: Fri, 21 Nov 2003 12:40:38 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@ultra60
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
In-Reply-To: <20031118124754.GA23333@mail.shareable.org>
Message-ID: <Pine.GSO.4.58.0311211238180.4918@ultra60>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz>
 <20031117064832.GA16597@mail.shareable.org> <Pine.GSO.4.58.0311171236420.29330@Juliusz>
 <20031117153323.GA18523@mail.shareable.org> <Pine.GSO.4.58.0311181254490.27011@Juliusz>
 <20031118124754.GA23333@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Jamie Lokier wrote:

[CUT]
> You are setting the first futex's word in userspace prior to the first
> futex wakeup, right?  Either 5 will detect that and return
> immediately, or it will reach 6 and the poll() returns immediately.
> No hole there.
>
> ( The async token passing flaw is that the _waker_ loses track of how
> many succesful wakeups it has sent; this is used by some
> implementations of fair semaphores, among other things.  That might be
> relevant to POSIX message queues but I do not see that it's relevant
> to the two futex problem you described. )
>

Thanks for information. I was wrongly assmuming that poll will block.
After checking the code - I know I have made a mistake.

Regards
Krzysiek
