Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWDSXlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWDSXlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWDSXlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:41:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20486 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751242AbWDSXlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:41:13 -0400
Date: Thu, 20 Apr 2006 01:41:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org,
       greg@kroah.com, hch@infradead.org
Subject: Re: [RFC PATCH 1/2] Makefile: export-symbol usage report generator.
Message-ID: <20060419234112.GI25047@stusta.de>
References: <20060413123826.52D94470030@localhost> <20060418140927.GB11582@stusta.de> <1145489158.7323.169.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145489158.7323.169.camel@localhost>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 04:25:58PM -0700, Ram Pai wrote:
> On Tue, 2006-04-18 at 16:09 +0200, Adrian Bunk wrote:
> > On Thu, Apr 13, 2006 at 05:38:26AM -0700, Ram Pai wrote:
> > 
> > > I ran a report to extract export-symbol usage by kernel modules.  The results
> > > are at http://www.sudhaa.com/~ram/misc/export_report.txt
> > > 
> > > The report lists:
> > > 1. All the exported symbols and their usage counts by in-kernel modules.
> > > 2. for each in-kernel module, lists the modules and the exported symbols
> > > 	from those modules, that it depends on.
> > > 
> > > Highlights: 
> > > 	On x86 architecture
> > >  	(1) 880 exported symbols not used by any in-kernel modules.
> > >         (2) 1792 exported symbols used only once.
> > > 
> > > I hope this report/tool shall help all inkernel modules to revisit their usage
> > > of kernel interfaces.
> > > 
> > > This patch integrates the report-generator into the kernel build process. After
> > > applying this patch, invoke 'make export_report'  and it creates the report in
> > > Documentation/export_report.txt
> > >...
> > 
> > I like your patch, but I have observed two issues:
> > - please don't force an allmodconfig, simply use the currently compiled
> >   kernel 
> 
> Looking for ideas. Its hard to extract out the imported symbols unless
> they are compiled as modules. Running the report on a currently compiled
> kernel will miss most of the subsystems that are not compile as modules.
> Hence the report wont be complete.  Any suggestions?
>...

- it's a tool for kernel hackers who know what they are doing
- it's a tool to help you finding unused exports, but each one still
  requires manual verification

Besides this, e.g. CONFIG_SMP=n brings you more modules and therefore a 
better coverage than allmodconfig.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

