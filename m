Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUCVSiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 13:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUCVSiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 13:38:46 -0500
Received: from waste.org ([209.173.204.2]:62669 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262217AbUCVSip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 13:38:45 -0500
Date: Mon, 22 Mar 2004 12:38:36 -0600
From: Matt Mackall <mpm@selenic.com>
To: Alexander Simon <Al.Simon@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing kernel uncompressing address
Message-ID: <20040322183836.GB8366@waste.org>
References: <405D73D7.70905@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405D73D7.70905@t-online.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 11:52:07AM +0100, Alexander Simon wrote:
> Hi!
> 
> I have an old Toshiba Satellie Pro Laptop with broken RAM.
> I thought it could be no problem getting it to work with the BadRAM patch.
> But first RAM Errors occur at 2M and last until 32M
> Unfornately, the RAM Chips are on board, so no chance of replacing them.
> When I try to load a kernel image from diskette, it unpacks the kernel 
> image without errors. But when it tries to start that kernel it stops or 
> reboots.
> If I keep the kernel very very small, it starts, but I would have to 
> exclude TCP/IP code, causing the system unusable.
> 
> After studying arch/i386/boot/compressed/head.S and misc.c of 2.4.24 for 
> a long time, i found out that the kernel is uncompressed to 0x100000.
> Stupidly, I'm not familiar with assembler code. So I just changed the 
> 0x100000 to 0xF00000 (should be 16M?!? memtest86 reported the range 
> 15M-18M OK, however...) in line 77 in head.S and line 309 in misc.c.
> Of couse it did NOT work :[.
> I would need to high loaded kernel anyway, again because of TCP/IP.

That's part of it, you'll also need to tweak the boot-time page tables
and whatnot to cover all of the space you need.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
