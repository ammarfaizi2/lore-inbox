Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbSLDRCv>; Wed, 4 Dec 2002 12:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbSLDRCv>; Wed, 4 Dec 2002 12:02:51 -0500
Received: from air-2.osdl.org ([65.172.181.6]:55788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266994AbSLDRCn>;
	Wed, 4 Dec 2002 12:02:43 -0500
Date: Wed, 4 Dec 2002 09:06:43 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Mike Galbraith <efault@gmx.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Duncan Sands <baldrick@wanadoo.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reserving physical memory at boot time
In-Reply-To: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2002, Richard B. Johnson wrote:

| On Wed, 4 Dec 2002, Mike Galbraith wrote:
|
| > At 08:25 AM 12/4/2002 -0500, Richard B. Johnson wrote:
| > >On 3 Dec 2002, Alan Cox wrote:
| > >
| > > > On Tue, 2002-12-03 at 21:11, Richard B. Johnson wrote:
| > > > > If you need a certain page reserved at boot-time you are out-of-luck.
| > > >
| > > > Wrong - you can specify the precise memory map of a box as well as use
| > > > mem= to set the top of used memory. Its a painful way of marking a page
| > > > and it only works for a page the kernel isnt loaded into.
| > > >
| > >
| > >If you are refering to the "reserve=" kernel parameter, I don't
| > >think it works for memory addresses that are inside existing RAM.
| > >I guess if you used the "mem=" parameter to keep the kernel from
| > >using that RAM, the combination might work, but I have never
| > >tried it.
| >
| > reserve= is for IO ports (kernel/resource.c). I think Alan was referring to
| > mem=exactmap.
| >
| > If Duncan didn't have the pesky requirement that his module work in an
| > unmodified kernel, it would be easy to use __alloc_bootmem() to reserve an
| > address range and expose via /proc.  But alas...
| >
|
| Well that parameter is not documented in:
|
|         .../linux-2.4.18/Documentation/kernel-parameters.txt.
|
| Perhaps it's a 2.5.++ thing.

Patch for 'mem=exactmap' in 2.4 was submitted several weeks ago and
Alan merged it into -ac.  It does need to be pushed to Marcelo...

-- 
~Randy

