Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136501AbREDUXw>; Fri, 4 May 2001 16:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136502AbREDUXm>; Fri, 4 May 2001 16:23:42 -0400
Received: from bitmover.com ([207.181.251.162]:25361 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S136501AbREDUXa>;
	Fri, 4 May 2001 16:23:30 -0400
Date: Fri, 4 May 2001 13:23:26 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Cc: linux@3ware.com
Subject: Re: 3ware 6410 RAID 10 performance?
Message-ID: <20010504132326.H6437@work.bitmover.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux@3ware.com
In-Reply-To: <20010504130103.T22922@work.bitmover.com> <20010504131239.G6437@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20010504131239.G6437@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And yet more data -

Under 2.2.15 using 3ware's driver rather than the one shipped with the
kernel, one complete read goes at 35MB/sec (nice).  The second one starts
out there and then drops down to 4MB/sec at the 1.2GB offset.

Here's the cool part - if I unmount, rmmod the driver, insmod, mount, and
then run again, I get exactly the same behavior as above.

This starts to sound like some resource in the kernel or the card are
getting used up and removing the card frees them.

Has anyone seen this besides me?

On Fri, May 04, 2001 at 01:12:39PM -0700, Larry McVoy wrote:
> More data:
> 
> the test file is 2GB in size.
> When I do a reboot and time the reading of the entire file,
> the first time the performance is great, 27MB.
> The second time it sucks, 2.7MB.
> I tried clearing memory by allocating and pounding on an array of 512MB 
> (size of main mem), that clears out memory but the performance still 
> sucks.
> Unmounting and remounting the drive does not help.
> 
> Any ideas?
> 
> On Fri, May 04, 2001 at 01:01:03PM -0700, Larry McVoy wrote:
> > I'm looking for people who know about the 3ware 6410 driver.  I've got one
> > of these and sometimes it goes fast and sometimes it doesn't.  The bad 
> > case seems to happen after memory has a lot of cached blocks in it.
> > 
> > I've tried 2.2.15, 2.4.4, and 2.4.3-ac9 and they all behave pretty similarly.
> > 
> > I'm most interested in seeing this fixed in the 2.4 series so if there is
> > someone who wants to go into a test/debug cycle with me, speak up.  I'd
> > really like this thing to work well.
> > 
> > hardware config:
> > 
> > K7 @ 750Mhz
> > ASUS K7V motherboard
> > 512MB
> > 4x 3c905
> > boot disk on the motherboard
> > 4 WD 40GB 7200 drives on one 3ware 6410
> > matrox g200 AGP
> > -- 
> > ---
> > Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
