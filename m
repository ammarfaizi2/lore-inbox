Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319254AbSH2Qkr>; Thu, 29 Aug 2002 12:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319255AbSH2Qkr>; Thu, 29 Aug 2002 12:40:47 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:37248 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S319254AbSH2Qkq> convert rfc822-to-8bit;
	Thu, 29 Aug 2002 12:40:46 -0400
From: Andris Pavenis <pavenis@latnet.lv>
To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
       "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.20-pre4-ac2] fix broken i810_audio DMA (?)
Date: Thu, 29 Aug 2002 19:43:39 +0300
User-Agent: KMail/1.4.6
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jim Radford <radford@robotics.caltech.edu>,
       Doug Ledford <dledford@redhat.com>
References: <1030585168.2548.18.camel@volans> <1030638379.2726.3.camel@voyager>
In-Reply-To: <1030638379.2726.3.camel@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200208291943.40069.pavenis@latnet.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 August 2002 19:26, Juergen Sawinski wrote:
> F*ck. This time the patch attached.
> Thanx Jim.

Thanks. It works for me (both from KDE-3.1-beta1 and RealPlayer).

Andris

>
> George
>
> On Thu, 2002-08-29 at 03:39, Juergen Sawinski wrote:
> > Changes:
> > -remove dma reset in stop_{dac,adc}
> >  (from ICH4 manual: contents of all Bus master related registers to be
> >   reset; so, probably some registers are not re-initilized properly on
> >   consecutive re-opening of /dev/dsp ???)
> > -remove writes to OFF_CIV, instead set LVI relative to CIV
> >
> > and some stuff that was already in the last diff I send to the list:
> > -implement a codec ID <-> IO register offset mapping
> > -in i810_ioctl, case SNDCTL_DSP_CHANNELS: only touch bits 20:21
> >  off GLOB_CNT (multichannel capabilities)
> > -AMD 8111 has 6 hw channels so I must have mmio (but I don't have
> >  any docs to verify this)
> > -minor fixes
> >
