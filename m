Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTIALTH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 07:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTIALTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 07:19:06 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:6854 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261869AbTIALTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 07:19:04 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Matt Porter <mporter@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030901060040.GH748@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
	 <20030829103943.A18608@home.com>  <20030901060040.GH748@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062415022.13369.9.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 01 Sep 2003 12:17:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-01 at 07:00, Jamie Lokier wrote:
> Matt Porter wrote:
> > PPC440GX, non cache coherent, L1 icache is VTPI, L1 dcache is PTPI
> 
> The cache looks very coherent to me.

The only x86 which will show the user non cache coherent behaviour (and
then only in a really weird situation) is SMP Pentium Pro due to the
store fence errata.

The Winchip is non SMP so you won't see CPU<->CPU store ordering changes
although I guess mmap of mmio space might show you stuff if you really
tried hard

The Geode has bus level magic so its out of order but if you ask then
you get the right answer (kind of the zen question about falling trees
implemented in silicon).


