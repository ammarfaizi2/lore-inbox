Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263346AbRGIOf2>; Mon, 9 Jul 2001 10:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263675AbRGIOfR>; Mon, 9 Jul 2001 10:35:17 -0400
Received: from [130.236.252.129] ([130.236.252.129]:25615 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S263346AbRGIOfD>;
	Mon, 9 Jul 2001 10:35:03 -0400
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: reading/writing CMOS beyond 256 bytes? 
Newsgroups: linux.kernel
In-Reply-To: <19706.994679164@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1010706094624.519A-100000@chaos.analogic.com> 
Message-Id: <20010709142456.C756436F9C@hog.ctrl-c.liu.se>
Date: Mon,  9 Jul 2001 16:24:56 +0200 (CEST)
From: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <19706.994679164@redhat.com> you write:
>root@chaos.analogic.com said:
>> Motherboard manufacturers who have rewritable BIOS chips now leave one
>> page (typically 64k) for startup parameters. This is erased and
>> written using the magic provided by the chip vendors.
>
>You often have to do chipset-specific magic to enable the WE and Vpp lines
>to BIOS flash chips. See drivers/mtd/maps/l440gx.c in my working tree for 
>an example.

Another way might be to use the PnP BIOS to read and write the 
ESCD tables.  I wrote some code to do this a few years ago and
after beating up the code a bit more I can at least read the ESCD 
tables from the BIOS.  If anyone is interested in doing something 
with the code it can be found at:

    http://acolyte.hack.org/~wingel/escd/

The advantage of using the PnP BIOS is that the PnP BIOS knows
about the format of the data in BIOS and how to do all the 
chipset specific stuff.  The disadantage is as usual that a lot
of BIOSes are buggy.

    /Christer

-- 
"Just how much can I get away with and still go to heaven?"
