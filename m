Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265086AbRGEO1r>; Thu, 5 Jul 2001 10:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264812AbRGEO1h>; Thu, 5 Jul 2001 10:27:37 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:43225 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264972AbRGEO1T>; Thu, 5 Jul 2001 10:27:19 -0400
Message-ID: <3B44797F.DD9EAC99@uow.edu.au>
Date: Fri, 06 Jul 2001 00:28:15 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT please; Sybase 12.5
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com>,
		<3B3C4CB4.6B3D2B2F@kegel.com>; from dank@kegel.com on Fri, Jun 29, 2001 at 02:39:00AM -0700 <20010705155350.O17051@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Andrew Morton took care of ext3 O_DIRECT support (included into the ext3
> patch and conditional to #ifdef KERNEL_HAS_O_DIRECT that he asked me to
> add to the latest o_direct patches). (you know O_DIRECT is 99% common
> code, so supporting new fs is almost a no brainer)

Sorry, haven't looked at that yet.

ext3 journals data.  That's unique and it breaks things (or rather,
things break it).   It'd be trivial to support O_DIRECT in ext3's
writeback mode (metadata-only), but nobody uses that.

>From a quick look it seems that we'll need fs-private implementations
of generic_direct_IO() and brw_kiovec() at least.

I'll take a closer look.

-
