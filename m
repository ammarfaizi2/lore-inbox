Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277029AbRJHRpu>; Mon, 8 Oct 2001 13:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277034AbRJHRpl>; Mon, 8 Oct 2001 13:45:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3078 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277030AbRJHRp2>; Mon, 8 Oct 2001 13:45:28 -0400
Date: Mon, 8 Oct 2001 10:44:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave McCracken <dmccr@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Provide system call to get task id
In-Reply-To: <E15qcua-00010T-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110081042430.8212-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Oct 2001, Alan Cox wrote:
>
> Really the fix is to back out the stupid getpid hack. The thread group
> is known by user space and can be managed by user space

I agree on a purely technical level, but the same could be said about all
the other group ID stuff too, so..

I'll add a gettid(), except I won't be moving reserved system calls
around. I didn't even realize I had removed gettid - it was there in the
2.4.0-test kernels that implemented the signal groups, and I meant to only
revert the unsafe signals stuff..

		Linus

