Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316791AbSEWPk2>; Thu, 23 May 2002 11:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSEWPk1>; Thu, 23 May 2002 11:40:27 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:64137
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316791AbSEWPk0>; Thu, 23 May 2002 11:40:26 -0400
Date: Thu, 23 May 2002 08:40:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 67
Message-ID: <20020523154016.GF6269@opus.bloom.county>
In-Reply-To: <3CEB466B.3090604@evision-ventures.com> <20020522171329.GG1209@opus.bloom.county> <3CEBC576.4060703@evision-ventures.com> <20020522173137.GH1209@opus.bloom.county> <3CEBC9EE.2090701@evision-ventures.com> <20020522184722.GB5575@opus.bloom.county> <3CEC8768.1060002@evision-ventures.com> <20020523152614.GE6269@opus.bloom.county> <3CECFD7E.7090207@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 04:32:30PM +0200, Martin Dalecki wrote:
> Uz.ytkownik Tom Rini napisa?:
> 
> >
> >Er, you've lost me.  The call to ide_release_dma(ch) used to be guarded
> >by (CONFIG_BLK_DEV_IDEDMA) && !CONFIG_DMA_NONPCI) but is now just
> >guarded by CONFIG_BLK_DEV_IDEDMA.  Am I missing something (should all
> >drivers be implementing ide_release_dma()?)
> 
> Ahh this case. Well please look even closer:
> 
> ./include/linux/ide.h:extern void ide_release_dma(struct ata_channel *);
> ./arch/cris/drivers/ide.c: * - added ide_release_dma
> ./arch/cris/drivers/ide.c:void ide_release_dma(struct ata_channel *ch)
> 
> All right?

Ah, so everyone has to implement ide_release_dma() now then.  Thanks.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
