Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSHGV6Z>; Wed, 7 Aug 2002 17:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSHGV6Z>; Wed, 7 Aug 2002 17:58:25 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:41406 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S313070AbSHGV6Z>; Wed, 7 Aug 2002 17:58:25 -0400
Message-Id: <200208072210.g77MAt9g000182@pool-141-150-241-241.delv.east.verizon.net>
Date: Wed, 7 Aug 2002 18:10:51 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 LILO FreeBSD partition problems
References: <200208032300.g73N0Pix000183@pool-141-150-241-241.delv.east.verizon.net> <20020803233035.GA29008@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020803233035.GA29008@win.tue.nl>; from aebr@win.tue.nl on Sun, Aug 04, 2002 at 01:30:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Sat, Aug 03, 2002 at 07:00:21PM -0400, Skip Ford wrote:
> 
> > While running 2.5.30 I receive this error when running LILO with a
> > FreeBSD partition in lilo.conf
> > 
> >   Device 0x0300: Invalid partition table, 3rd entry
> >     3D address:     1/0/530 (534240)
> >     Linear address: 1/14/8446 (8514450)
> > 
> > I removed the fbsd entry and LILO had no problems.  I then booted
> > to 2.4 and readded the fbsd partition and it installed fine.
> 
> [snip]
>
> If you want the kernel to provide lilo with some random numbers,
> add boot parameters to the kernel invocation: hda=C,H,S.
> If you want lilo to ignore the discrepancy between what the
> disk said and the kernel repeated and what it sees in the
> partition table, try the global option "ignore-table".
> (I never tried, this is just from the man page.)

Ok.  I finally got the nerve to try "ignore-table" and it seems to work.
LILO successfully installs and all partitions successfully boot.

It still prints the above ugly message every time though.

> If lilo tries to check 3D addresses in spite of the fact that
> it got a "linear" or "lba32" option, then that is a lilo bug,
> especially if it aborts on a difference.

-- 
Skip
