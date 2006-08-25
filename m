Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422844AbWHYW6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422844AbWHYW6G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 18:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWHYW6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 18:58:05 -0400
Received: from xenotime.net ([66.160.160.81]:10138 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422844AbWHYW6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 18:58:03 -0400
Date: Fri, 25 Aug 2006 16:01:15 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: another NUMA build error
Message-Id: <20060825160115.7f768797.rdunlap@xenotime.net>
In-Reply-To: <a762e240608251544t2e15ec8dq5a8f95f02eecb0a4@mail.gmail.com>
References: <20060824213559.1be3d60f.rdunlap@xenotime.net>
	<20060825144350.27530dfb.kamezawa.hiroyu@jp.fujitsu.com>
	<20060825103507.4f2d193e.rdunlap@xenotime.net>
	<a762e240608251544t2e15ec8dq5a8f95f02eecb0a4@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 15:44:58 -0700 Keith Mannthey wrote:

> On 8/25/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Fri, 25 Aug 2006 14:43:50 +0900 KAMEZAWA Hiroyuki wrote:
> >
> > > On Thu, 24 Aug 2006 21:35:59 -0700
> > > "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> > >
> > > > Hi,
> > > > I was just trying to reproduce that 'register_one_node'
> > > > build error (and couldn't even with the supplied .config file;
> > > > weird).  Anyway, after I enabled CONFIG_NUMA (but not CONFIG_ACPI),
> > > > I got the following error message.  Seems that some config
> > > > options should prevent this config from even being possible
> > > > to create.  Any ideas or suggestions?
> > > >
> > > Hi, there are 2 ways.
> > >
> > > 1. allow only 2 configs for i386/NUMA
> > >       - CONFIG_NUMA + CONFIG_ACPI + CONFIG_ACPI_SRAT
> > >       - CONFIG_NUMA + CONFIG_X86_NUMAQ
> > > 2. allow this and fix include/asm-i386/mmzone.h
> > >       - CONFIG_NUMA + !CONFIG_ACP
> > >
> > > Which is sane ?
> >
> > I really can't answer that one.  The people who care about
> > NUMA would have to do that.  It just shouldn't be possible
> > to make a config with a build error like this.
> 
> I thought there was a patch fix a while ago to fix this build issue.
> If you want to anything that includes the SUMMIT sub arch you need
> CONFIG_ACPI_SRAT.
> 
> Option 1 is a good solution as only NUMAQ and ACPI_SRAT have tables
> that are used to setup NUMA in the kernel.
> 
> > OK, I prefer option 2 because it is more generic (not hardware-
> > specific).  Someone else can prefer option 1 because it is
> > hardware-specific.  :)
> 
> I guess I am that other person.  Really you only want/need NUMA if you
> have ACPI_SRAT (Summit) or NUMAQ.

That's fine.  Any fix is OK with me, as long as a .config
won't generate a build error.

---
~Randy
