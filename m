Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFBuX>; Fri, 5 Jan 2001 20:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRAFBuE>; Fri, 5 Jan 2001 20:50:04 -0500
Received: from smtp3.libero.it ([193.70.192.53]:42389 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S129324AbRAFBt4>;
	Fri, 5 Jan 2001 20:49:56 -0500
Date: Sat, 6 Jan 2001 04:50:50 +0100
From: antirez <antirez@invece.org>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
Cc: "'antirez@invece.org'" <antirez@invece.org>, Greg KH <greg@wirex.com>,
        Heitzso <xxh1@cdc.gov>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Johannes Erdfelt'" <johannes@erdfelt.com>
Subject: Re: USB broken in 2.4.0
Message-ID: <20010106045050.C1748@prosa.it>
Reply-To: antirez@invece.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEBE@orsmsx31.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEBE@orsmsx31.jf.intel.com>; from randy.dunlap@intel.com on Fri, Jan 05, 2001 at 04:48:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 04:48:00PM -0800, Dunlap, Randy wrote:
> This rings a small bell with me.
> There was a change by Dan Streetman IIRC to limit
> usbdevfs bulk transfers to PAGE_SIZE (4 KB for x86,
> or 0x1000).  Anything larger than that returns
> an error (-EINVAL).

Yes, devio.c, proc_bulk():

        if (len1 > PAGE_SIZE)
                return -EINVAL;

Actually it is the max transfer size I can reach.
I guess that to limit the page size can be an impementation
advantage but it may slow-down a bit some userspace driver.
I feel that even if the linux way is to implement the USB
drivers in kernel space a full-featured USB user space access
should be allowed.

antirez
(please cc me)

-- 
Salvatore Sanfilippo              |                      <antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger antirez@tella.alicom.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
