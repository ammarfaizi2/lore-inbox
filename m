Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290390AbSAPJ2s>; Wed, 16 Jan 2002 04:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290395AbSAPJ2i>; Wed, 16 Jan 2002 04:28:38 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:58632 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S290390AbSAPJ2S>; Wed, 16 Jan 2002 04:28:18 -0500
From: Norbert Preining <preining@logic.at>
Date: Wed, 16 Jan 2002 10:27:38 +0100
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, andre@linuxdiskcert.org
Subject: Re: [BUG] 2.4.18.3, ide-patch, read_dev_sector hangs in read_cache_page
Message-ID: <20020116102738.A21977@alpha.logic.tuwien.ac.at>
In-Reply-To: <E16QU3F-0005g6-00@libra.cus.cam.ac.uk> <20020115160315.A2515@alpha.logic.tuwien.ac.at> <20020116094935.A20738@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020116094935.A20738@alpha.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton!

On Mit, 16 Jan 2002, preining wrote:
> I have tried to follow the trace of the kernel but it looks to me as
> read_cache_page is never called or printk in it are not executed. I filled

Stupid me, somehow KERN_DEBUG was not shown.

I traced it down from
read_cache_page -> lock_page -> __lock_page -> schedule

There it hangs and I was not able with my stupid methods or printk-ing
to find the place where it hangs in sched.c (Maybe because of recursive
calls to sched by printk).

One more thing: Taking off hdf from the ide controller and everything
works.
Another: same with 2.4.18-pre4

Best wishes

Norbert

-----------------------------------------------------------------------
Norbert Preining <preining@logic.at> 
University of Technology Vienna, Austria            gpg DSA: 0x09C5B094
-----------------------------------------------------------------------
WORMELOW TUMP (n.)

Any seventeen-year-old who doesn't know about anything at all in the
world other than bicycle gears.

			--- Douglas Adams, The Meaning of Liff 
