Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUHFRSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUHFRSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268219AbUHFROg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:14:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38313 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268192AbUHFRNp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:13:45 -0400
Message-ID: <4113BA7B.20405@pobox.com>
Date: Fri, 06 Aug 2004 13:06:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Maxey <dwm@austin.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brett Russ <russb@emc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
References: <200408061623.i76GNfDa016095@falcon10.austin.ibm.com>
In-Reply-To: <200408061623.i76GNfDa016095@falcon10.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Maxey wrote:
> On Thu, 05 Aug 2004 21:45:59 EDT, Jeff Garzik wrote:
> 
>>ATAPI works too.....  assuming your CD/DVD drive never encounters a 
>>CHECK CONDITION requiring REQUEST SENSE to be issued...  ;-)
> 
> 
>   Heh.  Where should one start looking to get this enabled?  I have to
>   admit that I have given the code only a few minutes viewing.

top of include/linux/libata.h:

/*
  * compile-time options
  */
#undef ATA_FORCE_PIO            /* do not configure or use DMA */
#undef ATA_DEBUG                /* debugging output */
#undef ATA_VERBOSE_DEBUG        /* yet more debugging output */
#undef ATA_IRQ_TRAP             /* define to ack screaming irqs */
#undef ATA_NDEBUG               /* define to disable quick runtime checks */
#undef ATA_ENABLE_ATAPI         /* define to enable ATAPI support */
#undef ATA_ENABLE_PATA          /* define to enable PATA support in some
                                  * low-level drivers */
#undef ATAPI_ENABLE_DMADIR      /* enables ATAPI DMADIR bridge support */

