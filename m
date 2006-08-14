Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWHNBZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWHNBZP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWHNBZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:25:15 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:26521 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751349AbWHNBZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:25:14 -0400
Subject: Re: [PATCH for review] [140/145] i386: mark cpu_dev structures as
	__cpuinitdata
From: Magnus Damm <magnus@valinux.co.jp>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200608111126_MC3-1-C7CA-65CE@compuserve.com>
References: <200608111126_MC3-1-C7CA-65CE@compuserve.com>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 10:26:23 +0900
Message-Id: <1155518783.5764.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 11:24 -0400, Chuck Ebbert wrote:
> In-Reply-To: <20060810193740.9133413C0B@wotan.suse.de>
> 
> On Thu, 10 Aug 2006 21:37:40 +0200, Andi Kleen wrote:
> 
> > From: Magnus Damm <magnus@valinux.co.jp>
> > 
> > The different cpu_dev structures are all used from __cpuinit callers what
> > I can tell. So mark them as __cpuinitdata instead of __initdata. I am a
> > little bit unsure about arch/i386/common.c:default_cpu, especially when it
> > comes to the purpose of this_cpu.
> 
> But none of these CPUs supports hotplug and only one (AMD) does SMP.
> So this is just wasting space in the kernel at runtime.

How could this be wasting space? If you compile with CONFIG_HOTPLUG_CPU
disabled then __cpuinitdata will become __initdata - ie the same as
before. Not a single byte wasted what I can tell.

The first version of this patch simply added a missing __init to some
function, but I was then corrected by akpm that __cpuinit should be used
instead.

Thanks,

/ magnus

