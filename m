Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312735AbSCVP7H>; Fri, 22 Mar 2002 10:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312736AbSCVP65>; Fri, 22 Mar 2002 10:58:57 -0500
Received: from GS176.SP.CS.CMU.EDU ([128.2.198.136]:46485 "EHLO
	gs176.sp.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S312735AbSCVP6p>; Fri, 22 Mar 2002 10:58:45 -0500
Message-Id: <200203221559.g2MFxwd32172@gs176.sp.cs.cmu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        dave@zarzycki.org
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot 
In-Reply-To: Your message of "Fri, 22 Mar 2002 12:50:11 +0100."
             <3C9B1A73.2070606@evision-ventures.com> 
Date: Fri, 22 Mar 2002 10:59:58 -0500
From: John Langford <jcl@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	int port = hwif->index ? 0x5c : 0x58;
>	int portFIFO = hwif->channel ? 0x55 : 0x54;
>
>The usage of hwif->index *is* wrong.

Switching hwif->index to hwif->channel doesn't help here - same
failure mode.

I've confirmed that the problem is isolated to
"CONFIG_BLK_DEV_ALI15X3=y" as Dave suggested.

Any other ideas?

-John
