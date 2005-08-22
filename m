Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVHVUos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVHVUos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVHVUoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:44:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33554 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751166AbVHVUoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:44:21 -0400
Date: Mon, 22 Aug 2005 22:44:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strange CRASH_DUMP dependencies
Message-ID: <20050822204417.GI9927@stusta.de>
References: <20050821225310.GE5726@stusta.de> <20050822062302.GA4293@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822062302.GA4293@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 11:53:02AM +0530, Vivek Goyal wrote:
> On Mon, Aug 22, 2005 at 12:53:10AM +0200, Adrian Bunk wrote:
> > config CRASH_DUMP
> > 	bool "kernel crash dumps (EXPERIMENTAL)"
> > 	depends on EMBEDDED
> > 	depends on EXPERIMENTAL
> > 	depends on HIGHMEM
> > 	help
> > 	  Generate crash dump after being started by kexec.
> > 
> > Two questions:
> > - If it has any dependencies on kexec, why isn't there a dependency?
> 
> crashdump has got dependency on kexec but not in the same kernel. What
> I mean is that as of today two kernels are involved in this process. First
> kernel is crashing kernel which should have enabled CONFIG_KEXEC and second
> kernel (capture kernel) is one which captures the dump and should have
> CONFIG_CRASH_DUMP enabled. Second kernel need not to have CONFIG_KEXEC
> enabled for catpturing dump. Hence CRASH_DUMP is not directly dependent
> on CONFIG_KEXEC.

Sounds reasonable.

> > - Is there any sane reason for the dependency on EMBEDDED?
> > 
> 
> I believe this was introduced because large servers can have huge amount
> of memory (running into Tera Bytes) and saving all that memory might not be
> practical. Hence it was perceived that until some filtering mechanism is
> implemented, it is more suited for small systems.
>...

It seems you have a wrong impression of what EMBEDDED in the kernel 
does.

There is _not_ a choice EMBEDDED/WORKSTATION/SERVER.

EMBEDDED is an option that shows "save space at any cost" options.

It allows you to tell gcc to generate slower but faster code or to 
deselect options in the "do this only if you _really_ know what you are 
doing" class.

> Thanks
> Vivek

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

