Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWDROJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWDROJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWDROJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:09:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15109 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932095AbWDROJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:09:29 -0400
Date: Tue, 18 Apr 2006 16:09:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org,
       greg@kroah.com, hch@infradead.org
Subject: Re: [RFC PATCH 1/2] Makefile: export-symbol usage report generator.
Message-ID: <20060418140927.GB11582@stusta.de>
References: <20060413123826.52D94470030@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413123826.52D94470030@localhost>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 05:38:26AM -0700, Ram Pai wrote:

> I ran a report to extract export-symbol usage by kernel modules.  The results
> are at http://www.sudhaa.com/~ram/misc/export_report.txt
> 
> The report lists:
> 1. All the exported symbols and their usage counts by in-kernel modules.
> 2. for each in-kernel module, lists the modules and the exported symbols
> 	from those modules, that it depends on.
> 
> Highlights: 
> 	On x86 architecture
>  	(1) 880 exported symbols not used by any in-kernel modules.
>         (2) 1792 exported symbols used only once.
> 
> I hope this report/tool shall help all inkernel modules to revisit their usage
> of kernel interfaces.
> 
> This patch integrates the report-generator into the kernel build process. After
> applying this patch, invoke 'make export_report'  and it creates the report in
> Documentation/export_report.txt
>...

I like your patch, but I have observed two issues:
- please don't force an allmodconfig, simply use the currently compiled
  kernel 
- please output to stdout instead of a fixed file

This way, it would also be consistent with other Makefile targets like 
namespacecheck.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

