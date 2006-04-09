Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWDIPos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWDIPos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWDIPos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:44:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43269 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750796AbWDIPor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:44:47 -0400
Date: Sun, 9 Apr 2006 17:44:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Yasunori Goto <y-goto@jp.fujitsu.com>,
       tony.luck@intel.com, Andi Kleen <ak@muc.de>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: 2.6.17-rc1-mm1: drivers/acpi/numa.c compile error
Message-ID: <20060409154446.GE8454@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org> <20060407122757.GI7118@stusta.de> <20060407135937.56a84d44.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407135937.56a84d44.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 01:59:37PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > I'm getting the following compile error with CONFIG_ACPI_NUMA=y:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      drivers/acpi/numa.o
> > drivers/acpi/numa.c: In function 'acpi_numa_init':
> > drivers/acpi/numa.c:231: error: 'NR_NODE_MEMBLKS' undeclared (first use in this function)
> 
> I'm not quite sure how we managed that, but I guess
> unify-pxm_to_node-and-node_to_pxm.patch triggered it?

Yes, obviously (I got this error on i386):

 config ACPI_NUMA
        bool "NUMA support"
        depends on NUMA
-       depends on (IA64 || X86_64)
+       depends on (X86_32 || IA64 || X86_64)
        default y if IA64_GENERIC || IA64_SGI_SN2


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

