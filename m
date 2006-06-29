Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWF2VPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWF2VPR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWF2VPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:15:16 -0400
Received: from mail.gmx.de ([213.165.64.21]:16024 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932661AbWF2VPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:15:14 -0400
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       rlrevell@joe-job.com, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 29 Jun 2006 23:15:13 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5hfyhopb0s.wl%tiwai@suse.de>
Message-ID: <20060629211513.64980@gmx.net>
MIME-Version: 1.0
References: <20060628202753.198630@gmx.net> <s5hfyhopb0s.wl%tiwai@suse.de>
Subject: Re: [Alsa-devel] RFC: dma_mmap_coherent() for powerpc/ppc architecture
 and ALSA?
To: Takashi Iwai <tiwai@suse.de>
X-Authenticated: #6097454
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-------- Original-Nachricht --------
Datum: Thu, 29 Jun 2006 11:27:15 +0200
Von: Takashi Iwai <tiwai@suse.de>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
Betreff: Re: [Alsa-devel] RFC: dma_mmap_coherent() for powerpc/ppc architecture and ALSA?

> At Wed, 28 Jun 2006 22:27:53 +0200,
> Gerhard Pircher wrote:
> > 
> > Hi,
> > 
> > It took a little bit longer to integrate the patch, as I didn't figure
> out  first how to implement the __dma_mmap_coherent() function for PPC
> systems with CONFIG_NOT_COHERENT_CACHE defined. :)
> > 
> > Unfortunately my system still crashes within snd_pcm_mmap_data_nopage() 
> > (sound/core/pcm_native.c), as you can see below. I guess it tries to
> remap 
> > a DMA buffer allocated by the not cache coherent DMA memory allocation 
> > function in arch/ppc/kernel/dma-mapping.c.
> 
> Strange, nopage will be never called if you apply my patch and modify
> to use dma_mmap_coherent().
> 
> 
> Takashi
> 
That's indeed strange! I'm sure that the new code is called by the sound drivers. Should snd_pcm_mmap_data_nopage() not be used at all anymore, or are there any cases that could still trigger a call of snd_pcm_mmap_data_nopage()?

Gerhard

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
