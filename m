Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291319AbSBMCyA>; Tue, 12 Feb 2002 21:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291320AbSBMCxl>; Tue, 12 Feb 2002 21:53:41 -0500
Received: from gatekeeper-WAN.credit.com ([209.155.225.68]:12996 "EHLO
	gatekeeper") by vger.kernel.org with ESMTP id <S291319AbSBMCxY>;
	Tue, 12 Feb 2002 21:53:24 -0500
Date: Tue, 12 Feb 2002 18:52:59 -0800 (PST)
From: Eugene Chupkin <ace@credit.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, tmeagher@credit.com
Subject: Re: 2.4.x ram issues?
In-Reply-To: <E16aoic-0003of-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10202121849290.683-100000@mail.credit.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the output of /proc/mtrr with the 4gb image

reg00: base=0xe0000000 (3584MB), size= 512MB: uncachable, count=1
reg01: base=0x00000000 (   0MB), size=4096MB: write-back, count=1

And this is with 64gb image

reg00: base=0xe6000000 (3680MB), size=  32MB: uncachable, count=1
reg01: base=0xe8000000 (3712MB), size= 128MB: uncachable, count=1
reg02: base=0xf0000000 (3840MB), size= 256MB: uncachable, count=1
reg03: base=0x00000000 (   0MB), size=8192MB: write-back, count=1
reg04: base=0x200000000 (8192MB), size=4096MB: write-back, count=1
reg05: base=0x300000000 (12288MB), size=2048MB: write-back, count=1
reg06: base=0x380000000 (14336MB), size=1024MB: write-back, count=1
reg07: base=0x3c0000000 (15360MB), size= 512MB: write-back, count=1


I'm not sure if that looks right, any ideas?

Thanks
-E


On Wed, 13 Feb 2002, Alan Cox wrote:

> > I have a problem with high ram support on 2.4.7 to 2.4.17 all behave the
> > same. I have a quad Xeon 700 box with 16gb of ram on an Intel SKA4 board.
> > The ram is all the same 16 1gb PC100 SDRAM modules from Crucial. If I
> > compile the kernel with high ram (64gb) support, my system runs very slow,
> > it takes about 15 minutes for make menuconfig to come up. If I  recompile
> > the kernel with 4gb support, it runs perfectly normal and very fast, but I
> > have 12 gigs that I can't use. Is this a known issue? Is there a fix? I
> > tried just about everything and I am all out of options. Please help!
> 
> Thats almost certainly indicating that the memory type range registers
> were not set up correcly by the BIOS. Check /proc/mtrr and also ask your
> vendor about BIOS updates to address the problem
> 
> (If there aren't any you can hack around it but its not nice to let vendors
>  get away with bugs if that indeed is what it is)
> 

