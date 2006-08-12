Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWHLTQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWHLTQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWHLTQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:16:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:30898 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964932AbWHLTQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:16:21 -0400
Date: Sat, 12 Aug 2006 12:16:19 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: mlord@pobox.com, axboe@suse.de, sam@ravnborg.org, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: VMPLIT question
Message-ID: <20060812191619.GE4919@us.ibm.com>
References: <20060812052744.GB4919@us.ibm.com> <1155393875.7574.88.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155393875.7574.88.camel@localhost.localdomain>
X-Operating-System: Linux 2.6.17.7 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.2006 [07:44:35 -0700], Dave Hansen wrote:
> On Fri, 2006-08-11 at 22:27 -0700, Nishanth Aravamudan wrote:
> > While building a newer kernel for a server (which had been running
> > 2.6.12 or so), I spent some time looking for how to set the VMSPLIT
> > .config options. I searched in menuconfig for VMSPLIT and was given a
> > few responses, all similar to this:
> > 
> >   â?????? Symbol: VMSPLIT_3G [=n]
> >   â?????? Prompt: 3G/1G user/kernel split
> >   â??????   Defined at arch/i386/Kconfig:488
> >   â??????   Depends on: <choice>             
> > 
> > Since depending on "<choice>" is less than helpful, I did an rgrep and
> > found what it actually depends on:
> > 
> >   depends on EXPERIMENTAL && !X86_PAE
> >   prompt "Memory split" if EMBEDDED
> >   default VMSPLIT_3G
> > 
> > and was able to determine that I needed the patch recently submitted by
> > Dave Hansen to enable VMSPLIT for highmem kernels. Is there a reason
> > that menuconfig is not able to tell me this, i.e. this is a known
> > limitation of the choice syntax?
> 
> You need to ask for help with the high-level option, not the actual
> "choice":

The "high-level option" being ...? What did you search for in menuconfig
to get the following? And, in any case, how is it useful to return a
"(null)" symbol name?

>   ??? Symbol: (null) [=y]                                                                         ???
>   ??? Prompt: Memory split                                                                        ???
>   ???   Defined at arch/i386/Kconfig:494                                                          ???
>   ???   Depends on: EXPERIMENTAL && !X86_PAE && EMBEDDED                                          ???
>   ???   Location:                                                                                 ???
>   ???     -> Processor type and features                                                          ???
>   ???   Selected by: EXPERIMENTAL && !X86_PAE && EMBEDDED && m                                    ???

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
