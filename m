Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285753AbRLHCDP>; Fri, 7 Dec 2001 21:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285752AbRLHCDC>; Fri, 7 Dec 2001 21:03:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1030 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285750AbRLHCCt>;
	Fri, 7 Dec 2001 21:02:49 -0500
Date: Sat, 8 Dec 2001 03:02:36 +0100
From: Jens Axboe <axboe@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Marvin Justice <mjustice@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: highmem question
Message-ID: <20011208020236.GD32569@suse.de>
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <01120719300102.00764@bozo> <3C116CC6.2030808@zytor.com> <01120719534703.00764@bozo> <20011208015446.GC32569@suse.de> <3C1173B8.7030905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1173B8.7030905@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07 2001, H. Peter Anvin wrote:
> Jens Axboe wrote:
> 
> > On Fri, Dec 07 2001, Marvin Justice wrote:
> > 
> >>>There is no way of fixing it.
> >>>
> >>All I know is that a streaming io app I was playing with showed a drastic 
> >>performance hit when the kernel was compiled with CONFIG_HIGHMEM. On W2K we 
> >>saw no slowdown with 2 or even 4GB of RAM so I think solutions must exist.
> >>
> > 
> > That's because of highmem page bouncing when doing I/O. There is indeed
> > a solution for this -- 2.5 or 2.4 + block-highmem-all patches will
> > happily do I/O directly to any page in your system as long as your
> > hardware supports it. I'm sure we're beating w2k with that enabled :-)
> > 
> 
> 
> I didn't realize we were doing page bouncing for I/O in the 1-4 GB range.
>  Yes, this would be an issue.

All due to the "old" block stuff requiring a virtual mapping
traditionally for doing I/O. Ugh. So yes, we are bouncing _any_ highmem
page.

-- 
Jens Axboe

