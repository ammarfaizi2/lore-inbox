Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbQLUM4p>; Thu, 21 Dec 2000 07:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131115AbQLUM4g>; Thu, 21 Dec 2000 07:56:36 -0500
Received: from elektra.higherplane.net ([203.37.52.137]:43922 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S129563AbQLUM4b>; Thu, 21 Dec 2000 07:56:31 -0500
Date: Thu, 21 Dec 2000 23:31:19 +1100
From: john slee <indigoid@higherplane.net>
To: albertogli@telpin.com.ar
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Weird vmstat reports in 2.2.18
Message-ID: <20001221233119.C22707@higherplane.net>
In-Reply-To: <977324137.3a40c869a394e@webmail.telpin.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <977324137.3a40c869a394e@webmail.telpin.com.ar>; from albertogli@telpin.com.ar on Wed, Dec 20, 2000 at 11:55:37AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 11:55:37AM -0300, albertogli@telpin.com.ar wrote:
> I'm getting some strange reports with vmstat on a dual iPPro running 2.2.18,
> it doesnt happen very frequently, but i see it a lot when compiling something
> (kernel and mysql specially, not when compiling small stuff), though it doesnt
> look like a high-load issue. When the machine is idle (ie. most of the time at
> the moment) it doesnt show up.

i can consistently produce this on dual p3 600/2.2.17pre20.  in my case
it's the `ab' benchmark tool supplied with apache that helps reproduce
it.  incidentally i only noticed this in the last day or two, good to
know i'm not the only one. :-)

our setup is apache/php/postgresql.  fairly intensive pages.  i start
seeing vmstat oddities after about 15 concurrent requests.

> I wasnt able to trigger it in a predictable way, it just pops up...
> BUT if i open two vmstats in different consoles.. the number doesnt show up in
> both, just in one of them... so i'm not sure at all if this is a kernel bug, or
> just another (vmstat?) feature =)

the vmstat processes probably aren't reading /proc/* at exactly the same
time, so the numbers they see will likely be different... 

j.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
