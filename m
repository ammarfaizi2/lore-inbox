Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288850AbSBMTGZ>; Wed, 13 Feb 2002 14:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSBMTGR>; Wed, 13 Feb 2002 14:06:17 -0500
Received: from gatekeeper-WAN.credit.com ([209.155.225.68]:37855 "EHLO
	gatekeeper") by vger.kernel.org with ESMTP id <S288850AbSBMTGB>;
	Wed, 13 Feb 2002 14:06:01 -0500
Date: Wed, 13 Feb 2002 11:05:32 -0800 (PST)
From: Eugene Chupkin <ace@credit.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: linux-kernel@vger.kernel.org, tmeagher@credit.com
Subject: Re: 2.4.x ram issues?
In-Reply-To: <20020212213119.A25535@lynx.turbolabs.com>
Message-ID: <Pine.LNX.4.10.10202131058110.683-100000@mail.credit.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Feb 2002, Andreas Dilger wrote:

> On Feb 13, 2002  02:00 +0000, Alan Cox wrote:
> > > I have a problem with high ram support on 2.4.7 to 2.4.17 all behave the
> > > same. I have a quad Xeon 700 box with 16gb of ram on an Intel SKA4 board.
> > > The ram is all the same 16 1gb PC100 SDRAM modules from Crucial. If I
> > > compile the kernel with high ram (64gb) support, my system runs very slow,
> > > it takes about 15 minutes for make menuconfig to come up. If I  recompile
> > > the kernel with 4gb support, it runs perfectly normal and very fast, but I
> > > have 12 gigs that I can't use. Is this a known issue? Is there a fix? I
> > > tried just about everything and I am all out of options. Please help!
> > 
> > Thats almost certainly indicating that the memory type range registers
> > were not set up correcly by the BIOS. Check /proc/mtrr and also ask your
> > vendor about BIOS updates to address the problem
> 
> The other possibility with that much RAM is that the page tables are taking
> up all of the low RAM.  Andrea has a patch to put the page tables into
> higmem in the recent -aa kernels.

I got it, the 2.4.18pre2aa2/pte-highmem-5 but I can't seem to figure out
what to patch this on, I tried patching it on to 2.2.17, 2.2.18-pre1,
and 2.2.18-pre2. On all those I get a Hunk failed. Any feedback is
appreciated.

-E

