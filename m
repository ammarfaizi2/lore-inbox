Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285766AbRLHCLT>; Fri, 7 Dec 2001 21:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285765AbRLHCLE>; Fri, 7 Dec 2001 21:11:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15110 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285763AbRLHCKx>;
	Fri, 7 Dec 2001 21:10:53 -0500
Date: Sat, 8 Dec 2001 03:10:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Marvin Justice <mjustice@austin.rr.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: highmem question
Message-ID: <20011208021040.GE32569@suse.de>
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <01120719534703.00764@bozo> <20011208015446.GC32569@suse.de> <01120720102404.00764@bozo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01120720102404.00764@bozo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07 2001, Marvin Justice wrote:
> 
> > That's because of highmem page bouncing when doing I/O. There is indeed
> > a solution for this -- 2.5 or 2.4 + block-highmem-all patches will
> > happily do I/O directly to any page in your system as long as your
> > hardware supports it. I'm sure we're beating w2k with that enabled :-)
> 
> Will your patch lead to better performance than the CONFIGH_HIGHMEM=n case? 

No, it only makes sure that we do not take a hit with HIGHMEM enabled
for I/O.

> Unfortunately, W2K with any amount of memory beat Linux with no highmem (see 
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.3/0375.html ) so my 
> PHB decided to hold off on Linux for now.

Hmm I see, we can do better. With the patch you should do decently at
least with 2.4 too with 2gb of ram.

-- 
Jens Axboe

