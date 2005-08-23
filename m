Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVHWHPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVHWHPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVHWHPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:15:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:63383 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750803AbVHWHPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:15:02 -0400
Date: Tue, 23 Aug 2005 12:44:47 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strange CRASH_DUMP dependencies
Message-ID: <20050823071447.GB3766@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050821225310.GE5726@stusta.de> <20050822062302.GA4293@in.ibm.com> <20050822204417.GI9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822204417.GI9927@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 10:44:17PM +0200, Adrian Bunk wrote:
> On Mon, Aug 22, 2005 at 11:53:02AM +0530, Vivek Goyal wrote:
> > On Mon, Aug 22, 2005 at 12:53:10AM +0200, Adrian Bunk wrote:
> > > config CRASH_DUMP
> > > 	bool "kernel crash dumps (EXPERIMENTAL)"
> > > 	depends on EMBEDDED
> > > 	depends on EXPERIMENTAL
> > > 	depends on HIGHMEM
> > > 	help
> > > 	  Generate crash dump after being started by kexec.
> > > 
> > > Two questions:
> > > - If it has any dependencies on kexec, why isn't there a dependency?
> > 
> > crashdump has got dependency on kexec but not in the same kernel. What
> > I mean is that as of today two kernels are involved in this process. First
> > kernel is crashing kernel which should have enabled CONFIG_KEXEC and second
> > kernel (capture kernel) is one which captures the dump and should have
> > CONFIG_CRASH_DUMP enabled. Second kernel need not to have CONFIG_KEXEC
> > enabled for catpturing dump. Hence CRASH_DUMP is not directly dependent
> > on CONFIG_KEXEC.
> 
> Sounds reasonable.
> 
> > > - Is there any sane reason for the dependency on EMBEDDED?
> > > 
> > 
> > I believe this was introduced because large servers can have huge amount
> > of memory (running into Tera Bytes) and saving all that memory might not be
> > practical. Hence it was perceived that until some filtering mechanism is
> > implemented, it is more suited for small systems.
> >...
> 
> It seems you have a wrong impression of what EMBEDDED in the kernel 
> does.
> 

Yes, I misunderstood it.

Thanks
Vivek
