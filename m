Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317332AbSFCJbu>; Mon, 3 Jun 2002 05:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317336AbSFCJbt>; Mon, 3 Jun 2002 05:31:49 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:55683 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317332AbSFCJbs>;
	Mon, 3 Jun 2002 05:31:48 -0400
Date: Mon, 3 Jun 2002 11:31:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Derek Vadala <derek@cynicism.com>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Tedd Hansen <tedd@konge.net>,
        Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
Subject: Re: RAID-6 support in kernel?
Message-ID: <20020603113128.C13204@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv> <Pine.GSO.4.21.0206030213510.23709-100000@gecko.roadtoad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 02:25:22AM -0700, Derek Vadala wrote:
> On Mon, 3 Jun 2002, Roy Sigurd Karlsbakk wrote:
> 
> > It'll waste 9 drives, giving me a total capacity of 7n instead of 14n. 
> > And, by definition, RAID-6 _can_ withstand _any_ two-drive failure.
> 
> This is certainly not true. 
> 
> Combining N RAID-5 into a stripe wastes on N disks. 
> 
> If you combine two it wastes 2 disks, etc.
> 
> That is, for each RAID-5 you waste a single disk worth of storage for
> partiy. I don't know what equation you're using where you get 9 drives
> from.

He was thinking "mirror", not "stripe". Mirror of 2 RAID-5 arrays (would
be probably called RAID-15 (when there is a RAID-10 for mirrored stripe
arrays)), can withstand any two disks failing anytime. Even more for
certain combinations. But it is terribly inefficient.

> As far as it's ability to withstand _any_ 2-disk failure... I'm not sure
> what you mean by definition. RAID-6 implemations don't follow a standard
> because there isn't one. Depending on how it's implemented, RAID-6 is not
> necessarily able to withstand a filaure of any two disks. We can argue as
> much as you want, but I'm not willing to invest the time.
> 
> > With a 1500MHz Athlon on a typical file server where there's not much 
> > writes, the CPU is sitting there chrunching RC5-64 som 99,95 % of the 
> > time. I don't think it'll make much differnce with today's CPUs
> 
> It's up to you to decide if the performance trade-off is worthwhile. I
> merely trying to point out that system with 2 RAID-5 is likely to incur
> the same CPU hit as a single RAID-6, implemented in the kernel. 

-- 
Vojtech Pavlik
SuSE Labs
