Return-Path: <linux-kernel-owner+w=401wt.eu-S932524AbXAJEnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbXAJEnV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 23:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbXAJEnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 23:43:21 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:37762 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbXAJEnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 23:43:20 -0500
Date: Wed, 10 Jan 2007 10:13:16 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Horms <horms@verge.net.au>
Cc: "Zou, Nanhai" <nanhai.zou@intel.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Mohan Kumar M <mohan@in.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Kdump documentation update for 2.6.20
Message-ID: <20070110044316.GF8061@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20070110003110.GC28721@verge.net.au> <10EA09EFD8728347A513008B6B0DA77A086BA1@pdsmsx411.ccr.corp.intel.com> <20070110015333.GC21005@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110015333.GC21005@verge.net.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 10:53:34AM +0900, Horms wrote:
> On Wed, Jan 10, 2007 at 09:34:12AM +0800, Zou, Nanhai wrote:
> > > >
> > > > I am hoping it --args-linux will be required while loading vmlinux on
> > > > IA64? Because this is ELF file specific option. And this interface should
> > > > be common across all the architectures.
> > > >
> > > > > Then again, I could be wrong, I'm not sure that I understand
> > > > > --args-linux, I just know that I'm not using it :)
> > >
> > > I will take a look into this.
> > >
> >  args-linux is not support by IA64 kdump.
> > To have common interface, maybe we should support it by ignore this
> > arg like ppc does.
> 
> That sounds reasonable to me. Vivek, what do you think?
> 

I think we should recognize --args-linux while loading elf image and
all the processing we do for loading linux elf vmlinux should be done
under that option (The way i386 does). This will help if down the line
kexec ia64 loader allows loading some other elf images where one needs
to prepare elf boot notes (--args-elf). 

Eric is the best person to comment on this. He has got all the background
about these options.

Thanks
Vivek
