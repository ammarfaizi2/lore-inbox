Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317930AbSGRLLm>; Thu, 18 Jul 2002 07:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSGRLLl>; Thu, 18 Jul 2002 07:11:41 -0400
Received: from crisium.vnl.com ([194.46.8.33]:50698 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id <S317930AbSGRLLl>;
	Thu, 18 Jul 2002 07:11:41 -0400
Date: Thu, 18 Jul 2002 12:18:47 +0100
From: Dale Amon <amon@vnl.com>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : BusLogic cleanup
Message-ID: <20020718111847.GF19403@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, Frank Davis <fdavis@si.rr.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0206240104380.922-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206240104380.922-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2002 at 01:07:18AM -0400, Frank Davis wrote:
> Hello all,
>   The following patch removes some unneccessary (it seems) typedefs, and 
> adds in the pci_set_dma_mask() check mentioned in 
> Documentation/DMA-mapping.txt . Please review.

Did your Buslogic patch ever get included? I'm still
getting errors compiling 2.5.x as of .26 last night:

BusLogic.c:32: #error Please convert me to Documentation/DMA-mapping.txt
BusLogic.c: In function `BusLogic_DetectHostAdapter':
BusLogic.c:2841: warning: long unsigned int format, BusLogic_IO_Address_T arg (arg 2)
BusLogic.c: In function `BusLogic_QueueCommand':
BusLogic.c:3415: structure has no member named `address'
BusLogic.c: In function `BusLogic_BIOSDiskParameters':
BusLogic.c:4141: warning: implicit declaration of function `scsi_bios_ptable'
BusLogic.c:4141: warning: assignment makes pointer from integer without a cast
make[2]: *** [BusLogic.o] Error 1

Given that your patch was against .24, I would guess
it should be "relatively" safe against a .26 since it's
only driver code that everyone else seems to be ignoring.
