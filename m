Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbTA0REC>; Mon, 27 Jan 2003 12:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTA0REB>; Mon, 27 Jan 2003 12:04:01 -0500
Received: from bitmover.com ([192.132.92.2]:64155 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267242AbTA0RDz>;
	Mon, 27 Jan 2003 12:03:55 -0500
Date: Mon, 27 Jan 2003 09:13:08 -0800
From: Larry McVoy <lm@bitmover.com>
To: Steve Kenton <skenton@ou.edu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [FYI} The cygwin tool chain can *almost* build a 2.5.59 kernel
Message-ID: <20030127171308.GA24651@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Steve Kenton <skenton@ou.edu>, lkml <linux-kernel@vger.kernel.org>
References: <3E356598.EF799135@ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E356598.EF799135@ou.edu>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last I checked the kernel has file name conflicts, i.e., "README" and
"Readme" in the same directory in a windoze based file system.  You may
not notice it if you get your kernel with tar but if you get it with BK
then BK will detect that and tell you about it.   I don't remember which
files conflict but I know there are about 12 of them in the 2.5 kernel.

On Mon, Jan 27, 2003 at 11:00:08AM -0600, Steve Kenton wrote:
> Why anyone would want to is arguable.  I was looking at uml and line
> as I was downloading the 2.5.59 tar ball to peruse the source and the
> question of "Hmmm, I wonder if ..." drifted up, so I gave it a try.
> 
> After fixing a few things like output format and one link error,
> 
> make defconfig ARCH=i386
> 
> did the expected things, as did oldconfig, config, and menuconfig
> 
> The big problem is that the cygwin binutils, 'as' in particular do not
> support .subsection and .previous for some reason.  They are 2.13.?
> something special for cygwin which might explain it.  Anyway, once
> I hacked out the use of those (mainly in spinlocks, but a handful
> scattered around) and configed out a couple of problems like OSS it
> built a vmlinux (In windows PE format and probably not really useful)
> 
> It was an interesting "compile check" and might be helpful to some
> doing janitor work at schools etc. where you can't change to Linux
> or even dual boot because of "policies from above."
> 
> FYI
> 
> Steve
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
