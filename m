Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135441AbRAJTnj>; Wed, 10 Jan 2001 14:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132937AbRAJTn3>; Wed, 10 Jan 2001 14:43:29 -0500
Received: from Cantor.suse.de ([194.112.123.193]:27909 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135476AbRAJTnL>;
	Wed, 10 Jan 2001 14:43:11 -0500
Date: Wed, 10 Jan 2001 20:43:08 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
        Daniel Phillips <phillips@innominate.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010110204308.A5303@gruyere.muc.suse.de>
In-Reply-To: <20010110203307.A5106@gruyere.muc.suse.de> <E14GR76-0000nv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14GR76-0000nv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 10, 2001 at 07:40:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 07:40:49PM +0000, Alan Cox wrote:
> > Of course not by default, it would be a new clone flag (with default to on in
> > linuxthreads though, to not cause security holes in ported programs like today) 
> 
> I've seen exactly nil cases where there are any security holes in apps caused
> by that pthreads api non adherance. There are also far too many overheads
> imposed by implementing something in kernel space that is nearly useless,
> not needed for any application 99.9999% of users (possibly 100%) have and can
> be done just as well in the pthreads library glue - where it will only be
> a penalty to pthread using apps.

I have not seen a good way to implement it in user space yet.

> Making everyone suffer for a bad standard corner case is bad. Especially when
> the 'security hole' is pure FUD
>
As the thread started it's not only only needed for pthreads, but also for NFS
and setuid (actually NFS already implements it privately), and probably other network
file systems too.  So it's far from being only a "bad standard corner case". 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
