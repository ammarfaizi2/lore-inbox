Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbRDGTFw>; Sat, 7 Apr 2001 15:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRDGTFn>; Sat, 7 Apr 2001 15:05:43 -0400
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:14301 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130317AbRDGTFN>; Sat, 7 Apr 2001 15:05:13 -0400
Message-ID: <3ACF5924.4E321EF2@didntduck.org>
Date: Sat, 07 Apr 2001 14:15:00 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 kernel hangs on 486 machine at boot
In-Reply-To: <E14krU0-0002P8-00@the-village.bc.nu> <3ACB6524.C5986233@didntduck.org> <20010405102454.A31@(none)>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > > > Problem: Linux kernel 2.4 consistently hangs at boot on 486 machine
> > > >
> > > > Shortly after lilo starts the kernel it hangs at the following message:
> > > > Checking if this processor honours the WP bit even in supervisor mode...
> > > > <blinking cursor>
> > >
> > > Does this happen on 2.4.3-ac kernel trees ? I thought i had it zapped
> >
> > Yes, that fix in -ac should take care of it.  As to why only the 486
> > showed the problem, most 386's will not fault on the write protected
> > page (the whole reason for this test) and pentiums and later don't run
> > the test at all (assumed good).
> 
> We should not "assume good" -- to catch bugs like this one.

Well, in this case we cannot do the test if we enabled PSE (we would
mark the whole 4MB page read-only).  The test would have to use a
different page.

--
						Brian Gerst
