Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316759AbSEWPfy>; Thu, 23 May 2002 11:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316773AbSEWPfx>; Thu, 23 May 2002 11:35:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45581 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316759AbSEWPfx>; Thu, 23 May 2002 11:35:53 -0400
Message-ID: <3CECFD7E.7090207@evision-ventures.com>
Date: Thu, 23 May 2002 16:32:30 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 67
In-Reply-To: <3CEB466B.3090604@evision-ventures.com> <20020522171329.GG1209@opus.bloom.county> <3CEBC576.4060703@evision-ventures.com> <20020522173137.GH1209@opus.bloom.county> <3CEBC9EE.2090701@evision-ventures.com> <20020522184722.GB5575@opus.bloom.county> <3CEC8768.1060002@evision-ventures.com> <20020523152614.GE6269@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Tom Rini napisa?:

> 
> Er, you've lost me.  The call to ide_release_dma(ch) used to be guarded
> by (CONFIG_BLK_DEV_IDEDMA) && !CONFIG_DMA_NONPCI) but is now just
> guarded by CONFIG_BLK_DEV_IDEDMA.  Am I missing something (should all
> drivers be implementing ide_release_dma()?)

Ahh this case. Well please look even closer:

./include/linux/ide.h:extern void ide_release_dma(struct ata_channel *);
./arch/cris/drivers/ide.c: * - added ide_release_dma
./arch/cris/drivers/ide.c:void ide_release_dma(struct ata_channel *ch)

All right?

This was actually fixing a bug/mission :-)



