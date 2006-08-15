Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbWHOHoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbWHOHoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 03:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbWHOHoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 03:44:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14792 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965278AbWHOHoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 03:44:07 -0400
Subject: Re: [PATCH for review] [140/145] i386: mark cpu_dev structures as
	__cpuinitdata
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Magnus Damm <magnus@valinux.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <200608150249_MC3-1-C823-B57B@compuserve.com>
References: <200608150249_MC3-1-C823-B57B@compuserve.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 15 Aug 2006 09:43:23 +0200
Message-Id: <1155627804.3011.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 02:46 -0400, Chuck Ebbert wrote:
> In-Reply-To: <1155518783.5764.10.camel@localhost>
> 
> On Mon, 14 Aug 2006 10:26:23 +0900, Magnus Damm wrote:
> 
> > > > The different cpu_dev structures are all used from __cpuinit callers what
> > > > I can tell. So mark them as __cpuinitdata instead of __initdata. I am a
> > > > little bit unsure about arch/i386/common.c:default_cpu, especially when it
> > > > comes to the purpose of this_cpu.
> > > 
> > > But none of these CPUs supports hotplug and only one (AMD) does SMP.
> > > So this is just wasting space in the kernel at runtime.
> > 
> > How could this be wasting space? If you compile with CONFIG_HOTPLUG_CPU
> > disabled then __cpuinitdata will become __initdata - ie the same as
> > before. Not a single byte wasted what I can tell.
> 
> I was talking about wasted space with HOTPLUG_CPU enabled, of course.
> Nobody is ever going to hotplug a VIA, Cyrix, Geode, etc. CPU, yet your
> patch makes the kernel carry that code and data anyway.

remember that suspend uses software hot(un)plug as well...


