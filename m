Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285796AbRLHDrg>; Fri, 7 Dec 2001 22:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285795AbRLHDr1>; Fri, 7 Dec 2001 22:47:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50440 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285797AbRLHDrW>; Fri, 7 Dec 2001 22:47:22 -0500
Message-ID: <3C118D2B.9050807@zytor.com>
Date: Fri, 07 Dec 2001 19:46:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: war <war@starband.net>
CC: Jens Axboe <axboe@suse.de>, Marvin Justice <mjustice@austin.rr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: highmem question
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <01120719534703.00764@bozo> <20011208015446.GC32569@suse.de> <01120720102404.00764@bozo> <20011208021040.GE32569@suse.de> <3C118C6B.33EA558F@starband.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war wrote:

> I have 1GB of ram + HIGHMEM support on.
> 
> How much of a performance impact are we talking about?
> 
> 896MB of ram would be ok if HIGHMEM impacted the machine severely.
> 
> Has anyone done any benchmarks with HIGHMEM vs NO HIGHMEM?
> 


1 GB is really the worst case.  You don't gain too much memory this way, 
and suffer the necessary slowdown.

Personally I would support dropping the kernel boundary to 0xb8000000 
and use 0xb8000000-0xbfffffff for iomem; that way 1 GB wouldn't need 
HIGHMEM.

	-hpa


