Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUASR56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUASR56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:57:58 -0500
Received: from rat-3.inet.it ([213.92.5.93]:60857 "EHLO rat-3.inet.it")
	by vger.kernel.org with ESMTP id S261775AbUASR5D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:57:03 -0500
From: Paolo Ornati <ornati@lycos.it>
To: =?iso-8859-15?q?J=FCrgen=20Urban?= <jur@sysgo.com>
Subject: Re: Lost memory, total memory size is not correct
Date: Mon, 19 Jan 2004 18:58:05 +0100
User-Agent: KMail/1.5.2
References: <200401191222.23449.jur@sysgo.com>
In-Reply-To: <200401191222.23449.jur@sysgo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401191845.58901.ornati@lycos.it>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 January 2004 12:22, Jürgen Urban wrote:
> Hello,
>
> I tried to get the amount of total physical memory. I looked at
> /proc/meminfo and found this line (2.4.18):
>
> MemTotal:        30844 kB
>
> But this is not correct the system have 32768 kB Memory. I looked at
> kernel sources and I found the variable max_mapnr. Can I use it to detect
> the correct memory size? It seems that it stores the maximum number of
> pages usable. So I can convert it with macro K() in
> linux/fs/proc/proc_misc.c to a value in kB.

There are some addresses that cannot be used on PC because there is 
something mapped (for example System ROM...), you can see these regions 
doing "cat /proc/iomem".

Here there is my output:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07febfff : System RAM
  00100000-00298596 : Kernel code
  00298597-00322f27 : Kernel data
07fec000-07feefff : ACPI Tables
07fef000-07ffefff : reserved
07fff000-07ffffff : ACPI Non-volatile Storage
de800000-de81ffff : Promise Technology, Inc. 20265
df000000-df0000ff : Cologne Chip Designs GmbH ISDN network controller 
[HFC-PCI]
df800000-df8000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  df800000-df8000ff : 8139too
e0000000-e3dfffff : PCI Bus #01
  e0000000-e1ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
e3f00000-e5ffffff : PCI Bus #01
  e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
e6000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved


Bye

-- 
	Paolo Ornati
	Linux v2.4.24

