Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262733AbTCPTr1>; Sun, 16 Mar 2003 14:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262737AbTCPTr1>; Sun, 16 Mar 2003 14:47:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56297 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262733AbTCPTr0>; Sun, 16 Mar 2003 14:47:26 -0500
Date: Sun, 16 Mar 2003 20:58:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.5.64-mm8: link error with CONFIG_NUMA and !CONFIG_SMP
Message-ID: <20030316195812.GH10253@fs.tum.de>
References: <20030316024239.484f8bda.akpm@digeo.com> <20030316191012.GG10253@fs.tum.de> <86910000.1047843162@[10.10.2.4]> <88340000.1047843845@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88340000.1047843845@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 11:44:06AM -0800, Martin J. Bligh wrote:
> >> I get many errors at the final linking when compiling a kernel with
> >> CONFIG_NUMA enabled but CONFIG_SMP disabled:
> > 
> > Well don't do that then ;-)
> > 
> >  # Common NUMA Features
> > config NUMA
> >         bool "Numa Memory Allocation Support"
> >         depends on (HIGHMEM64G && (X86_NUMAQ || (X86_SUMMIT && ACPI && !ACPI_HT_
> > ONLY)))
> > 
> > I guess SMP should be added to the dependencies, but the whole things 
> > getting a little twisted. Let me try and sort it out properly this afternoon.
> 
> Ah ... maybe you were referring to the bit when Andy was going to get this
> working on a standard PC for distros (actually, they still have SMP images,

I ran into it since -mm adds a " || X86_PC" to the depends line of
CONFIG_NUMA.

> I think ... but still). Not quite finished yet, and Andy's off on vacation ;-)
> Avoid that combo for now ... will fix soon.

It's not an extremely urgent problem.

> M.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

