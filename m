Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSGRPI3>; Thu, 18 Jul 2002 11:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318127AbSGRPI3>; Thu, 18 Jul 2002 11:08:29 -0400
Received: from crisium.vnl.com ([194.46.8.33]:4109 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id <S318121AbSGRPIJ>;
	Thu, 18 Jul 2002 11:08:09 -0400
Date: Thu, 18 Jul 2002 16:15:16 +0100
From: Dale Amon <amon@vnl.com>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : BusLogic cleanup - architecture dependencies
Message-ID: <20020718151516.GF4358@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, Frank Davis <fdavis@si.rr.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207181458140.29194-100000@linux-box.realnet.co.sz> <3D36CC41.8070409@si.rr.com> <20020718142829.GC4358@vnl.com> <3D36D8F1.2040803@si.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D36D8F1.2040803@si.rr.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As noted below, Frank Davis suggests I fire this back into the
list for discussion.

On Thu, Jul 18, 2002 at 11:04:17AM -0400, Frank Davis wrote:
> Dale,
>   Here's what I know....
> not all architectures define an 'address' variable in the struct 
> scatterlist, so some archs will compile with no problems, others won't. 
> If you're using a i386, there isn't an address variable. Here's what I 
> suggest....email linux-kernel with the problem report for 2.5.26, and 
> explain what I have stated above. I could have a bunch of #ifdef for 
> each arch, but thats plain crazy. I'd be interested in what some other 
> developers suggest. Sorry, I couldn't provide you a patch.
> 
> Regards,
> Frank
> 

==============================================================================

Zwane Mwaikambo wrote:
>On Thu, 18 Jul 2002, Dale Amon wrote:
>
>
>>On Mon, Jun 24, 2002 at 01:07:18AM -0400, Frank Davis wrote:
>>
>>>Hello all,
>>> The following patch removes some unneccessary (it seems) typedefs, and 
>>>adds in the pci_set_dma_mask() check mentioned in 
>>>Documentation/DMA-mapping.txt . Please review.
>>
>
>The driver needs more than just the dma mask set.
>
>
>>Did your Buslogic patch ever get included? I'm still
>>getting errors compiling 2.5.x as of .26 last night:
>
>
>Probably didn't get in because the driver is still not compliant with the 
>new kernel requirements for PCI/DMA
>
>
>>BusLogic.c:32: #error Please convert me to Documentation/DMA-mapping.txt
>>BusLogic.c: In function `BusLogic_DetectHostAdapter':
>>BusLogic.c:2841: warning: long unsigned int format, BusLogic_IO_Address_T 
>>arg (arg 2)
>>BusLogic.c: In function `BusLogic_QueueCommand':
>>BusLogic.c:3415: structure has no member named `address'
>
>
>That probably wants sg_dma_address()
>
>
>>BusLogic.c: In function `BusLogic_BIOSDiskParameters':
>>BusLogic.c:4141: warning: implicit declaration of function 
>>`scsi_bios_ptable'
>>BusLogic.c:4141: warning: assignment makes pointer from integer without a 
>>cast
>>make[2]: *** [BusLogic.o] Error 1
