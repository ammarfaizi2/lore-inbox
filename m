Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285794AbRLHDo4>; Fri, 7 Dec 2001 22:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285795AbRLHDoq>; Fri, 7 Dec 2001 22:44:46 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:48067 "EHLO
	c0mailgw10.prontomail.com") by vger.kernel.org with ESMTP
	id <S285794AbRLHDog>; Fri, 7 Dec 2001 22:44:36 -0500
Message-ID: <3C118C6B.33EA558F@starband.net>
Date: Fri, 07 Dec 2001 22:43:39 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Marvin Justice <mjustice@austin.rr.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: highmem question
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <01120719534703.00764@bozo> <20011208015446.GC32569@suse.de> <01120720102404.00764@bozo> <20011208021040.GE32569@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 1GB of ram + HIGHMEM support on.

How much of a performance impact are we talking about?

896MB of ram would be ok if HIGHMEM impacted the machine severely.

Has anyone done any benchmarks with HIGHMEM vs NO HIGHMEM?


Jens Axboe wrote:

> On Fri, Dec 07 2001, Marvin Justice wrote:
> >
> > > That's because of highmem page bouncing when doing I/O. There is indeed
> > > a solution for this -- 2.5 or 2.4 + block-highmem-all patches will
> > > happily do I/O directly to any page in your system as long as your
> > > hardware supports it. I'm sure we're beating w2k with that enabled :-)
> >
> > Will your patch lead to better performance than the CONFIGH_HIGHMEM=n case?
>
> No, it only makes sure that we do not take a hit with HIGHMEM enabled
> for I/O.
>
> > Unfortunately, W2K with any amount of memory beat Linux with no highmem (see
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.3/0375.html ) so my
> > PHB decided to hold off on Linux for now.
>
> Hmm I see, we can do better. With the patch you should do decently at
> least with 2.4 too with 2gb of ram.
>
> --
> Jens Axboe
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

