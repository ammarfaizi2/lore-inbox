Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWH3Vtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWH3Vtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWH3Vtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:49:39 -0400
Received: from xenotime.net ([66.160.160.81]:33963 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932134AbWH3Vti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:49:38 -0400
Date: Wed, 30 Aug 2006 14:53:00 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: piet@bluelane.com
Cc: vgoyal@in.ibm.com, George Anzinger <george@wildturkeyranch.net>,
       Andrew Morton <akpm@osdl.org>,
       Discussion
	 "list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Subhachandra Chandra <schandra@bluelane.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [Crash-utility] Patch to use gdb's bt in crash - works
 great with kgdb! - KGDB in Linus Kernel.
Message-Id: <20060830145300.7d728f6c.rdunlap@xenotime.net>
In-Reply-To: <1156974093.29300.103.camel@piet2.bluelane.com>
References: <44EC8CA5.789286A@redhat.com>
	<20060824111259.GB22145@in.ibm.com>
	<44EDA676.37F12263@redhat.com>
	<1156966522.29300.67.camel@piet2.bluelane.com>
	<20060830204032.GD30392@in.ibm.com>
	<1156974093.29300.103.camel@piet2.bluelane.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 14:41:32 -0700 Piet Delaney wrote:

> On Wed, 2006-08-30 at 16:40 -0400, Vivek Goyal wrote:
> > On Wed, Aug 30, 2006 at 12:35:21PM -0700, Piet Delaney wrote:
> > > > 
> > > > Simple question -- and to be quite honest with you -- I don't
> > > > understand why you wouldn't want to simply use gdb alone
> > > > in this case?
> > > 
> > > I don't see any reason for core file not to be read correctly by
> > > gdb. It's convenient to use gdb directly sometimes, for example
> > > while using the ddd GUI.
> > > 
> > 
> > You can run gdb to open core files as of today but the debugging
> > capability will be limited. For ex. kernel core headers have the info
> > of linearly mapped region only and they don't contain the virt address
> > info of non-linearly mapped regions. So one can not debug the non-linearly
> > mapped regions like modules.
> 
> Amit's modified gdb might help for that problem. I haven't used
> it but it allows gdb to load debug information about modules. You
> can also use a script Amit wrote to explicitly load module info
> into stock gdb; that also might work with kernel core files.
> 
> > 
> > > kgdb isn't having any problems with kernel threads back traces.
> > > The kernel objects are tweaked with dwarf code, but I see no
> > > problem with using the same paradigm with crash. Works great.
> > > 
> > 
> > Can you give some more details on what do you mean by kernel objects
> > are tweaked with dwarf code. 
> 
> Attached is the cfi_annotations.patch patch from the kgdb-2.6.16 patch
> which is part of the kgdb patch series. I believe George Anzinger used 
> a similar dwarf patch in the 2.6 mm series patches that Andrew provided.
> I think Tom Rini wrote both of them. 

ENOPATCH

---
~Randy
