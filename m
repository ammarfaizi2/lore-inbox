Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWHRJ1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWHRJ1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWHRJ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:27:34 -0400
Received: from mxout2.iskon.hr ([213.191.128.16]:31890 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S1751320AbWHRJ1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:27:33 -0400
X-Remote-IP: 213.191.142.123
X-Remote-IP: 213.191.128.133
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
To: Steffen Maier <smaier@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Chad Talbott <ctalbott@google.com>,
       Jochen Suckfuell <jo-lkml@suckfuell.net>, Jens Axboe <axboe@suse.de>
Subject: Re: ios_in_flight of CONFIG_BLK_STATS (still) negative in 2.4
References: <Pine.LNX.4.64.0608171924570.16659@nettc.informatik.uni-stuttgart.de>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJ1BMVEUAAABNIxCTRh9lLxXY
 0cuva0MHBQScUCmCOxmpWTL///8gEAk8Gw1gSXqgAAACWElEQVQ4y43TQW/TMBQAYHPpGS9CVCKX
 uRt1BJfVEhi0yxiwqTuh1VrbU7nkEi7rqLxMuzQB1UhcqFQFc0PrhLRxmYamSu6lbJUmmh+F02nE
 6UDiHSLFX+JnP/uBo38E+B8o/xX6z3fO7RGr3ICViUpiWJ+B/sRtuJ6WcRb622cAuDqUqmfgYOIC
 kJvCOAMbSkMinjrZM0BnuA41vGPCmf421g8X5NSwnMKh641oc1nFGj21l8LXxuuOlJgIEU489SuF
 Y/fSlzLi3JeFM3WRwkv3bqRFR2/rnvfDAK/kyx5jkjE2rzKQL+rxaWybsOHlubyS2ryZ4/hNwJHf
 k9JnbCc24PtpJ2qiYpHrJFvLxlQHAwHtmIbQKrHaR2Mfh4M2nKjztvJGc7WHT41aDUJbqcG+ck9I
 b9+En+14GM9t6uO9bO3XU2Al3IbWkyqEedT7VEmhWuLNAC3WkHAY+1wr/4H1gEvZXWQyqUm3m/6x
 TpEvu71prWSzlcIzHDgSO6yr68v9dyl8wwKh8ByiIkfIXzA2WBAC4xg6SIdjrKovRIB2l/My0hAY
 +zh6oacihAaSI6dTNu/uLsLEIuRDhN5mL3U1KEBClkoRWpgBIQQRSHD+JQub+krZowAjVJ4BqoVq
 6Mw0TjUvirwVIfx+FpYIDYMmEgs3AI5saFG6N9Nq1bYdq2Fs0WxzrpziEMZqckKDigmrOb0kCG3b
 KnYeVVJYa+QwCgmBscWdB+DiGtYaAFAkNEAaaQAXV2e+qtsVDBIgGvz7SfeOy0fgVTIObuGkVuRx
 5N+evoPT3+mFUpdZ4E28AAAAAElFTkSuQmCC
Date: Fri, 18 Aug 2006 11:27:30 +0200
In-Reply-To: <Pine.LNX.4.64.0608171924570.16659@nettc.informatik.uni-stuttgart.de>
	(Steffen Maier's message of "Thu, 17 Aug 2006 19:36:51 +0200 (CEST)")
Message-ID: <87hd0acs1p.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Maier <smaier@users.sourceforge.net> writes:

> Hello,
>
> in this posting I would like to analyze and discuss a bug(?), that
> causes the number of I/O requests in flight (ios_in_flight) of the
> extended block device statistics (CONFIG_BLK_STATS) to become and stay
> negative on various kernels of version 2.4. In turn, this leads to
> erroneous display of 100% utilization for certain classes of harddisk
> devices with 'iostat -x' and probably other statistic tools relying on
> the 13th (last but two) field (ios_in_flight) of extended block device
> statistics listed in /proc/partitions.
>
> First I encountered the behavior with 2.4.24 but could reproduce it
> with 2.4.33-rc3 (which is now the latest 2.4 kernel version 2.4.33).
> There have been various postings concerning this problem in recent
> years but to the best of my knowledge no ultimate fix has been merged
> into the mainstream kernel so far.

Have you tried this patch: http://linux.inet.hr/iostat_patch_2.4.html

It was made against 2.4.24 so you'll probably need to tweak it a
little bit before applying it cleanly to a newer 2.4, but I think it
deserves it's chance.
-- 
Zlatko
