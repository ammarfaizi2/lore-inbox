Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbRERSkL>; Fri, 18 May 2001 14:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261444AbRERSkB>; Fri, 18 May 2001 14:40:01 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:60288
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S261430AbRERSjw>; Fri, 18 May 2001 14:39:52 -0400
Date: Fri, 18 May 2001 11:39:40 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200105181839.f4IIdeQ01446@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: firenza@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: java/old_mmap allocation problems...
In-Reply-To: <20010518083305.C7657@telecoma.net>
In-Reply-To: <20010518083305.C7657@telecoma.net>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

>i'm having problems to convince java (1.3.1) to allocate more
>than 1.9gb of memory on 2.4.2-ac2 (SMP/6gb phys mem) or more
>than 1.1gb on 2.2.18 (SMP/2gb phys mem)...

Take a look at a thread from January starting at this point:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.1/0407.html

Basically the constraint you see is due to how Linux sets up the 4GB
address space on 32-bit i386 hardware.  If you need more than 1.9GB on
2.4.x, it's not too hard to change a couple constants in the kernel to
allow somewhat more.  Feel free to email me for more details if it is
not clear after reading the above thread.

Cheers, Wayne

