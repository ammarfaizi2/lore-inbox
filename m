Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSLHTmf>; Sun, 8 Dec 2002 14:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSLHTmf>; Sun, 8 Dec 2002 14:42:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261581AbSLHTmd>;
	Sun, 8 Dec 2002 14:42:33 -0500
Message-ID: <3DF3A240.2000508@pobox.com>
Date: Sun, 08 Dec 2002 14:49:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hps@intermeta.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with 3c59x module (3com 3c595 NIC)
References: <20021207164300.2a35f18d.mjr318@psu.edu> <3DF2738A.2447599@digeo.com> <3DF28151.40706@pobox.com> <asve18$2i0$1@forge.intermeta.de>
In-Reply-To: <asve18$2i0$1@forge.intermeta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmiedehausen wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
>>pci-skeleton.c and several of Don's drivers actually do do something 
>>else on TxUnderrun, twiddle DMA burst settings:
> 
> 
>>        if ((intr_status & TxUnderrun)
>>                && (np->tx_config & TxThresholdField) != 
>>TxThresholdField) {
>>                long ioaddr = dev->base_addr;
>>                np->tx_config += TxThresholdInc;
>>                writel(np->tx_config, ioaddr + TxMode);
>>                np->stats.tx_fifo_errors++;
>>        }
> 
> 
>>I wonder how feasible it is to do that on 3c59x hardware?
> 
> 
> I wonder whether this is not a layer violation. Shouldn't there be
> some sort of API call to do this?


that's unlikely because this operation is incredibly hardware-specific.

	Jeff



