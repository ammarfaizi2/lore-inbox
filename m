Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRCaTs3>; Sat, 31 Mar 2001 14:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132485AbRCaTsT>; Sat, 31 Mar 2001 14:48:19 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:28800
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S132484AbRCaTsI>; Sat, 31 Mar 2001 14:48:08 -0500
Date: Sat, 31 Mar 2001 11:47:06 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200103311947.f2VJl6K02148@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: khk@khk.net, linux-kernel@vger.kernel.org
Subject: Re: IDE Disk Corruption with 2.4.3 / NOT with AC kernels
In-Reply-To: <20010331084212.A11393@khk.net>
In-Reply-To: <20010331084212.A11393@khk.net>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> I run into some major disk corruptions on my IDE disk with the new
> 2.4.3 kernel version. [ . . . ] Now I did some more testing and found
> out that the Alan Cox series of kernel patches does not show these
> problems.

Hmm, 2.4.2-ac28 and 2.4.3 have the same collection of VIA fixups in
arch/i386/kernel/pci-pc.c.  Something else must be causing this?

> I was using the same .config file for all tests to make sure that the
> problem was not caused by a kernel configuration issue.


Did you run the .config through a 'make oldconfig' on each kernel, to
catch CONFIG name changes and so forth?

> This is my hardware:
>	- ABit KT7 board (KT133 chipset reported by lspci)

Does the BIOS have a setting that sounds like "System performance
setting" with choices such as "Optimal" or "Normal"? If so, try both
settings.  The terminology above is what is used on the ASUS A7V.

>Here is the output of lspci:

What would be quite useful, I think, is the output of 'lspci -xxx -s
0:0' under both the non-corrupting kernel (2.4.2-ac28) and the
corrupting kernel (2.4.3).  The output of 'dmesg' under both kernels
would also be good.

I find that a good way to present information like that, where most of
it should be the same and one is looking for the differences, is via
'diff -u --unified=1000 a b'.

Cheers,
Wayne

