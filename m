Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbSAUSYI>; Mon, 21 Jan 2002 13:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285589AbSAUSX6>; Mon, 21 Jan 2002 13:23:58 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:29965 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285161AbSAUSXr>; Mon, 21 Jan 2002 13:23:47 -0500
Message-ID: <3C4C5B26.3A8512EF@zip.com.au>
Date: Mon, 21 Jan 2002 10:17:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "David S. Miller" <davem@redhat.com>, reid.hekman@ndsu.nodak.edu,
        linux-kernel@vger.kernel.org, alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com>,
		<20020121.053724.124970557.davem@redhat.com>; from davem@redhat.com on Mon, Jan 21, 2002 at 05:37:24AM -0800 <20020121175410.G8292@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> 
> I think this is a very very minor issue, I doubt anybody ever triggered
> it in real life with linux.

It is said that the crashes cease when the `nopentium' option
is used, so it does appear that something is up.

I does seem that the nVidia driver is usually involved.

> And Gentoo is shipping a kernel with preempt and rmaps included, so it
> can crash anytime anyways, no matter how good the cpu is, so if they
> got crashes with such a kernel (maybe even with nvidia driver) that's
> normal. I was speaking today with a trusted party doing vm benchmarking
> and rmap crashes the kernel reproducibly under a stright calloc while
> swapping heavily, so clearly the implementation is still broken.

-rmap is still young.  I did some heavy stress testing on it a couple
of days ago and it was rock-solid, and performed well.

> preempt additionally will mess up all the locking into the nvidia driver as
> well. so if the combination of the two runs for some time without any
> lockup that's pure luck IMHO.

Yup.  But don't forget about the `nopentium' observations.

-
