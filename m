Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316760AbSEWP0e>; Thu, 23 May 2002 11:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316761AbSEWP0e>; Thu, 23 May 2002 11:26:34 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:61577
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316760AbSEWP0c>; Thu, 23 May 2002 11:26:32 -0400
Date: Thu, 23 May 2002 08:26:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 67
Message-ID: <20020523152614.GE6269@opus.bloom.county>
In-Reply-To: <3CEB466B.3090604@evision-ventures.com> <20020522171329.GG1209@opus.bloom.county> <3CEBC576.4060703@evision-ventures.com> <20020522173137.GH1209@opus.bloom.county> <3CEBC9EE.2090701@evision-ventures.com> <20020522184722.GB5575@opus.bloom.county> <3CEC8768.1060002@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 08:08:40AM +0200, Martin Dalecki wrote:
> Uz.ytkownik Tom Rini napisa?:
> >On Wed, May 22, 2002 at 06:40:14PM +0200, Martin Dalecki wrote:
> >
> >>Uz.ytkownik Tom Rini napisa?:
> >>
> >>>And when the PPC4xx drivers are ready to be submitted we'll need to add
> >>>in __powerpc__ tests too.  Can't we just keep CONFIG_DMA_NONPCI for now?
> >>
> >>Plese feel free to add them when and where they are needed.
> >>It's no problem to clean this all up
> >>then again if a true usage pattern emerges.
> >>And I have no problem with patches toching "core" driver stuff as long
> >>as the changes are justified I will integrate them with pleasure at time.
> >
> >
> >Okay. :)
> >
> >BTW, maybe it's part of the great IDE rewrite and all, but the
> >CONFIG_DMA_NONPCI part of drivers/ide/ide.c didn't get a __CRIS__ added
> >back in.
> 
> Please look at ide-features.c there is should be there.

Er, you've lost me.  The call to ide_release_dma(ch) used to be guarded
by (CONFIG_BLK_DEV_IDEDMA) && !CONFIG_DMA_NONPCI) but is now just
guarded by CONFIG_BLK_DEV_IDEDMA.  Am I missing something (should all
drivers be implementing ide_release_dma()?)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
