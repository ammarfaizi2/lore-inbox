Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263942AbRFRMgX>; Mon, 18 Jun 2001 08:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263943AbRFRMgM>; Mon, 18 Jun 2001 08:36:12 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26666 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263942AbRFRMgB>; Mon, 18 Jun 2001 08:36:01 -0400
Date: Mon, 18 Jun 2001 14:35:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: German Gomez Garcia <german@piraos.com>
Cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
Message-ID: <20010618143559.A23006@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0106181150320.11843-100000@hal9000.piraos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106181150320.11843-100000@hal9000.piraos.com>; from german@piraos.com on Mon, Jun 18, 2001 at 12:14:01PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2001 at 12:14:01PM +0200, German Gomez Garcia wrote:
> 	Hello,
> 
> 	I've running 2.4.5-ac15 for almost a day (22 hours) and I found
> some strange behaviour of the kswap, at least it was not present in
> 2.4.5-ac9. The swap memory increase with time as the cache dedicated
> memory also increase, that is swapping process at a very fast rate, even
> when no program is getting more memory. Is that the expected behaviour?
> 	An example, with no process running (just the usual daemons and
> none of them getting extra memory) the command:
> 
> 	free ; sleep 60; free
> 
>              total       used       free     shared    buffers     cached
> Mem:        513416     393184     120232        364      63276     254576
> -/+ buffers/cache:      75332     438084
> Swap:       530104      14228     515876
> 
>              total       used       free     shared    buffers     cached
> Mem:        513416     393192     120224        364      63276     258412
> -/+ buffers/cache:      71504     441912
> Swap:       530104      18064     512040
> 
> 	Any idea?

either apply this patch to 2.4.5ac15:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa3/00_fix-unusable-vm-on-alpha-1

(note it is not an alpha specific bug, it's just that I was triggering
all the time on alpha so I called the patch that way)

or better use 2.4.6pre3aa1:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre3aa1.bz2

If the problem persists let me know thanks.

Andrea
