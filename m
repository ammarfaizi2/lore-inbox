Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTKDX4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 18:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbTKDX4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 18:56:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:10417 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262575AbTKDX4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 18:56:41 -0500
Date: Tue, 4 Nov 2003 15:56:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Paul Venezia <pvenezia@jpj.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
In-Reply-To: <3FA83ACC.5060700@redhat.com>
Message-ID: <Pine.LNX.4.44.0311041555300.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Nov 2003, Ulrich Drepper wrote:
>
>  This was, I think, the result of one of the last changes in the locking
> code where the libc side wasn't updated correctly.  I've done this and
> this is what I see:

Goodie. 

> drepper@ht 20031104-2$ time ./u > /dev/null
> real    0m1.272s
> user    0m1.270s
> sys     0m0.000s
> 
> drepper@ht 20031104-2$ time LD_ASSUME_KERNEL=2.4.1 ./u > /dev/null
> real    0m0.316s
> user    0m0.320s
> sys     0m0.000s
> 
> drepper@ht 20031104-2$ time LD_LIBRARY_PATH=. ./u > /dev/null
> real    0m0.207s
> user    0m0.210s
> sys     0m0.000s
> 
> The first is the old nptl code, the second LinuxThreads, the third the
> current nptl code.

Now _that_ looks a hell of a lot better. Thanks.

		Linus

