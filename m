Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSKXXf1>; Sun, 24 Nov 2002 18:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSKXXf1>; Sun, 24 Nov 2002 18:35:27 -0500
Received: from [195.223.140.107] ([195.223.140.107]:62879 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261950AbSKXXf0>;
	Sun, 24 Nov 2002 18:35:26 -0500
Date: Mon, 25 Nov 2002 00:42:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, KELEMEN Peter <fuji@elte.hu>
Subject: Re: NFS performance ...
Message-ID: <20021124234231.GE12212@dualathlon.random>
References: <200211241521.09981.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211241521.09981.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 03:23:01PM +0100, Marc-Christian Petersen wrote:
> Hi Peter,
> 
> > I have a very simple NFS setup over a siwtched 100Mbit/s network.
> > client is Celeron 400MHz/256M RAM, using XFS
> > server is dual Pentium Pro 200MHz/1G RAM, using XFS
> > server is running Linux 2.4.19-pre8aa3.
> >
> > Network bandwith can be utilized, because ICMP flooding the
> > server results in ~20000 kbit/s network traffic (as of
> > iptraf), but NFS (v3,udp) write performance is unacceptably
> > slow (around 300 KiB/sec), same results with the following
> > kernels:
> > Linux 2.4.18-WOLK3.1
> > Linux 2.4.18-wolk3.7.1
> > Linux 2.4.20-pre8aa2
> > However, with 2.4.19-rmap14b-xfs the very same NFS
> > performance tops out at 2.54 MiB/sec.  What's the catch?
> I think Andrea and me have something in our kernels that may cause it. For me 
> I don't know what that can be. I even have no idea what it can be :(
> 
> Andrea, you?

nfs runs at 10mbyte/sec both directions for me, not on xfs if that
matters. can you try if you can reproduce with ext2 on both sides just
in case, also please try with 2.4.20rc2aa1 (the elevator-lowlatency will
make the system slower in some workload like dbench compared to rc1aa1,
but it doesn't matter for you since your bottleneck must be in the
network/fs layer not the blkdev layer).

> 
> Peter, have you also tested v3 over tcp?
> 
> ciao, Marc
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
