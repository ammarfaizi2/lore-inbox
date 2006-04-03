Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWDCJH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWDCJH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWDCJH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:07:56 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:37849 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751673AbWDCJHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:07:55 -0400
Date: Mon, 3 Apr 2006 18:08:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-Id: <20060403180839.f14a9464.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060403090207.GB15606@flint.arm.linux.org.uk>
References: <20060402210003.GA11979@elf.ucw.cz>
	<20060402220807.GD13901@flint.arm.linux.org.uk>
	<20060402222314.GC12166@elf.ucw.cz>
	<20060403091504.ecd341a3.kamezawa.hiroyu@jp.fujitsu.com>
	<20060403073653.GA13275@flint.arm.linux.org.uk>
	<20060403164434.fdb5020c.kamezawa.hiroyu@jp.fujitsu.com>
	<20060403175603.7a3dd64f.kamezawa.hiroyu@jp.fujitsu.com>
	<20060403090207.GB15606@flint.arm.linux.org.uk>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2006 10:02:07 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> In turn, that means that we can pass it whatever address we happen to
> have available at the time, or whichever is simpler to calculate.
> 
interesting :)

> In the cases you're looking at (pfn to map number) giving it pfn <<
> PAGE_SHIFT is entirely sufficient, and is in fact optimal for
> performance.

Ok, I'll post fixed patch, which uses LOCAL_MAP_NR((pfn) << PAGE_SHIFT)

Thank you for advices!

--Kame

