Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265846AbRF2KOM>; Fri, 29 Jun 2001 06:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265848AbRF2KOD>; Fri, 29 Jun 2001 06:14:03 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:64747 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S265846AbRF2KNy>; Fri, 29 Jun 2001 06:13:54 -0400
Message-ID: <3B3C5571.3259CD32@kegel.com>
Date: Fri, 29 Jun 2001 03:16:17 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT please; Sybase 12.5
In-Reply-To: <E15Fuul-0008SJ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > the boss say "If Linux makes Sybase go through the page cache on
> > reads, maybe we'll just have to switch to Solaris.  That's
> > a serious performance problem."
> 
> Thats something you'd have to benchmark. It depends on a very large number
> of factors including whether the database uses mmap, the average I/O size
> and the like

I'll probably benchmark raw vs. non-raw I/O with Sybase ASE 12.5
on our application once we've come up to speed on basic performance
issues (we're database newbies).
 
> > It supports raw partitions, which is good; that might satisfy my
> > boss (although the administration will be a pain, and I'm not
> > sure whether it's really supported by Dell RAID devices).
> > I'd prefer O_DIRECT :-(
> 
> We already support raw direct I/O to devices themselves so they should support
> that - if not then Oracle I believe already does.

Haven't seen Sybase talk about O_DIRECT.  Not sure we want to
pony up the Sybase license fees.  (I'm still in denial about
databases in general, and hope I can switch to PostgreSQL
at some point.)

BTW, 
http://eval.veritas.com/webfiles/whitepapers/sybaseedition/sybase14_performance_paper.pdf
seems to show that raw beats O_DIRECT hands down on Solaris.
Will that hold on Linux, or is your (forthcoming?) O_DIRECT
higher performance than the one on Solaris?

Thanks,
Dan
