Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSFCJZ3>; Mon, 3 Jun 2002 05:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317337AbSFCJZ2>; Mon, 3 Jun 2002 05:25:28 -0400
Received: from jaded.cynicism.com ([206.129.95.68]:9743 "HELO
	jaded.cynicism.com") by vger.kernel.org with SMTP
	id <S317334AbSFCJZZ>; Mon, 3 Jun 2002 05:25:25 -0400
Date: Mon, 3 Jun 2002 02:25:22 -0700 (PDT)
From: Derek Vadala <derek@cynicism.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Tedd Hansen <tedd@konge.net>, Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv>
Message-ID: <Pine.GSO.4.21.0206030213510.23709-100000@gecko.roadtoad.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Roy Sigurd Karlsbakk wrote:

> It'll waste 9 drives, giving me a total capacity of 7n instead of 14n. 
> And, by definition, RAID-6 _can_ withstand _any_ two-drive failure.

This is certainly not true. 

Combining N RAID-5 into a stripe wastes on N disks. 

If you combine two it wastes 2 disks, etc.

That is, for each RAID-5 you waste a single disk worth of storage for
partiy. I don't know what equation you're using where you get 9 drives
from.

As far as it's ability to withstand _any_ 2-disk failure... I'm not sure
what you mean by definition. RAID-6 implemations don't follow a standard
because there isn't one. Depending on how it's implemented, RAID-6 is not
necessarily able to withstand a filaure of any two disks. We can argue as
much as you want, but I'm not willing to invest the time.

> With a 1500MHz Athlon on a typical file server where there's not much 
> writes, the CPU is sitting there chrunching RC5-64 som 99,95 % of the 
> time. I don't think it'll make much differnce with today's CPUs

It's up to you to decide if the performance trade-off is worthwhile. I
merely trying to point out that system with 2 RAID-5 is likely to incur
the same CPU hit as a single RAID-6, implemented in the kernel. 


---
Derek Vadala, derek@cynicism.com, http://www.cynicism.com/~derek

