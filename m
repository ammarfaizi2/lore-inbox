Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRJESWc>; Fri, 5 Oct 2001 14:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277543AbRJESWX>; Fri, 5 Oct 2001 14:22:23 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:42055 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S277541AbRJESWJ>; Fri, 5 Oct 2001 14:22:09 -0400
Date: Fri, 5 Oct 2001 14:22:15 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com, jgiglio@smythco.com
Subject: Re: 3ware discontinuing the Escalade Series
Message-ID: <20011005142215.C1221@ead45>
In-Reply-To: <20011005125259.B1221@ead45> <E15pYQ1-00071M-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E15pYQ1-00071M-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 05, 2001 at 06:05:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 06:05:49PM +0100, Alan Cox wrote:
> > I really like my 7800.  At this point I guess I'm going to convert from
> > hard to soft RAID, on the theory that (unfixed) bugs in the firmware are less
> > likely to botch JBOD. 
> 
> Except for RAID5 the softraid is also likely to outperform a hardware raid
> controller. With RAID5 its a CPU usage tradeoff

Nod.  I tested both configurations when I first got the cards, and
RAID0 and RAID10 tests with a dual Athlon and the 3ware 7800 showed Linux
soft-RAID outperforming.  I didn't save the hard-RAID results, but the following
is from a private e-mail I sent early in the summer:

RedHat 2.4.5-10smp on dual-Athlon 1.2GHz, 1GB RAM
Soft RAID0 with 4 IBM 41GB 7200RPM ATA-100 drives, chunk size 32K
ext2 w/4K blocks:

Version 1.01c       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
Tyan Thunder    10G 68828  99 138838  75 47756  33 48848  90 116166  61 229.2   1
K7 1.2GHz           ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  1208 100 +++++ +++ 16883  94  1220 100 +++++ +++  4476  99

I've been using hard-RAID simply because I've been playing with ext3
and LVM, and eliminating MD was one less interaction to worry about until now.

   -Bill Rugolsky
