Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265838AbUATWtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUATWtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:49:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:22449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265838AbUATWtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:49:32 -0500
Subject: Re: 2.6.1-mm5 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20040120222700.GJ12027@fs.tum.de>
References: <20040120000535.7fb8e683.akpm@osdl.org>
	 <1074614919.31724.0.camel@cherrypit.pdx.osdl.net>
	 <20040120215705.GG12027@fs.tum.de>
	 <1074636910.16765.14.camel@cherrytest.pdx.osdl.net>
	 <20040120222700.GJ12027@fs.tum.de>
Content-Type: text/plain
Message-Id: <1074639031.16764.23.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 20 Jan 2004 14:50:31 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 14:27, Adrian Bunk wrote:
> On Tue, Jan 20, 2004 at 02:15:10PM -0800, John Cherry wrote:
> >...
> > > Regarding allnoconfig:
> > > allnoconfig is a completely pathological case. It says "n" to support 
> > > for ISA, MCA and PCI, and neither networking nor any block devices.
> > > Besides, it says "n" to ELF, a.out and other binary formats.
> > > Demanding that allnoconfig should compile (although the resulting kernel 
> > > is completely useless) sounds a bit like demanding that no change in the 
> > > kernel is allowed to cause regressions in the dbench results...
> > > It is useful to omit a common option like e.g. PCI and check whether the 
> > > kernel still compiles, but allnoconfig removes nearly everything and 
> > > compiles such a small part of the kernel, that it's hardly useful.
> > 
> > I realize that allnoconfig is pathological, but it has caught several
> > config errors.  One would never try to boot from such a config.  Builds
> > based on allnoconfig have one purpose and that purpose is to validate
> > that defines are not used in cases where they are NOT defined in the
> > configuration.  Developers will quite often code a feature or
> > architecture with the config parameters always ON.  When the config
> > option is turned OFF, I will find compile errors, undefined variables,
> > and the like. This is actually quite a valuable screen.
> 
> The problem is that allnoconfig turns _everything_ off.
> 
> Cases like e.g. CONFIG_PROC_FS=n are interesting, but allnoconfig 
> doesn't really test them since allnoconfig also says "n" to all drivers.
> 
> > If developers feel that this has outlived its usefulness, I'll remove it
> > from the compile regressions.  However, all I have received at this
> > point have been requests to put an allnoconfig build into the
> > regressions.
> 
> I'd like to hear from the people requesting it why they consider it 
> useful.

I admit that when I added allnoconfig to the compile regressions, there
were several bugs that were exposed and fixed.  Since then, the
allnoconfig builds have been pretty quiet (until the i386 CPU change). 
If it is not interesting anymore, we should remove the allnoconfig build
option completely, since it imposes some work on anyone that modifies
Kconfig files.  I'd like to hear from anyone that wants to retain
allnoconfig as well.  I'd be glad to remove allnoconfig if that is the
consensus.

John


