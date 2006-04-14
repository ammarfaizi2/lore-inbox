Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWDNSCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWDNSCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWDNSCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:02:41 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:3901 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751357AbWDNSCk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:02:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=reXF1MhFCxl0/7OLBbWFq8RHgJyR1Ww8ZEw/kpzHv6+F3RMpmfr4xLZNJfzG+GtV43D/ZJK8tVH3ksosruHw1vmysCuNvrnl8+AkQRautT1ykWFCuo2JcLszSkpTMkexpYa1v96YUX9TcMAXpMBvMcGBnifIs5tiNiwrI9BPkyo=
Message-ID: <d4b6d3ea0604141102i7e50cfbdna04485fe2ae5c1d8@mail.gmail.com>
Date: Fri, 14 Apr 2006 11:02:40 -0700
From: "Michael Madore" <michael.madore@gmail.com>
To: "David Lang" <dlang@digitalinsight.com>
Subject: Re: Lockup/reboots on multiple dual core Opteron systems
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0604140937440.17345@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d4b6d3ea0604140948l36c8048ha819a6611c8fdad3@mail.gmail.com>
	 <Pine.LNX.4.62.0604140937440.17345@qynat.qvtvafvgr.pbz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/06, David Lang <dlang@digitalinsight.com> wrote:
> On Fri, 14 Apr 2006, Michael Madore wrote:
>
> > Hi,
> >
> > I have several dozen systems based on the AMD 8111/8131 chipset which
> > are experiencing lockups or reboots while under heavy stress.  All
> > systems are configured identically:
> >
> > (2) dual core Opteron 285 processors
> > 8 GB RAM
> > 1 IDE hard disk
> >
> > When the lockup occurs, there is no information printed to the screen,
> > and magic sysrq does not work.   The systems will often lockup within
> > a matter of hours, but sometimes they can run for several days before
> > locking up.
> >
> > The testing involves:
> >
> > 1) Allocate several GB of memory from each node and read/write to it.
> > 2) Perform lots of disk I/O
> > 3) Keep all cores busy
> >
> > I see the lockup no matter which kernel I try:
> >
> > 2.6.5 (SLES 9)
> > 2.6.9 (RHEL 4)
> > 2.6.16 (kernel.org)
> >
> > The systems will run perfectly stable under the following conditions:
> >
> > 1) Use a 32-bit kernel
> > or
> > 2) Boot 64-bit kernel with mem=3000M
> > or
> > 3) Don't perform any disk I/O during the test
> >
> > I have also tested the dual core 8GB combination on both NForce and
> > Serverworks based motherboards with the same results.  In this case
> > both systems were using SATA hard disks instead of IDE.
> >
> > Any ideas what the culprit could be?
> >
> > Mike
>
> I'm fighting similar problems on one machine at home (single dual core, 4G
> ram nforce 939 motherboard, 1 ide, 10 3ware, 1 adaptec controlled drives).
> It's locked up under the ubuntu and gentoo install disk kernels. I did
> have it running for a day and a half under 2.6.17-rc1, but I managed to
> corrupt the install and haven't gotten back to that kernel yet to confirm
> it's long-term stability.

Who makes your motherboard?  Also, how do you trigger the lockup?

Mike
