Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319274AbSH2QwL>; Thu, 29 Aug 2002 12:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319275AbSH2QwL>; Thu, 29 Aug 2002 12:52:11 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:29087 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319274AbSH2QwK>; Thu, 29 Aug 2002 12:52:10 -0400
Subject: Re: [PATCH 2.4.20-pre4-ac2] fix broken i810_audio DMA (?)
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: Jim Radford <radford@robotics.caltech.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020829095019.A29297@robotics.caltech.edu>
References: <1030585168.2548.18.camel@volans>
	<1030638379.2726.3.camel@voyager> 
	<20020829095019.A29297@robotics.caltech.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 18:59:02 +0200
Message-Id: <1030640343.2726.5.camel@voyager>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 18:50, Jim Radford wrote:
> On Thu, Aug 29, 2002 at 06:26:18PM +0200, Juergen Sawinski wrote:
> > F*ck. This time the patch attached.
> > Thanx Jim.
> 
> You're welcome.
> 
> It works better, but it's not fixed.
> 
>   o Playing through oss directly works like before
>   o No more scratchy sound on artsd startup.
>   o Playing one song at a time through artsd works.
>   o Giving two songs to ogg123 to play through artsd
>     works until you Ctrl-C to skip to the next song.
>     It then hangs (like before, but with no dmesg output)

Can you uncomment the DEBUG defines and try the ogg123 thing again?
 
> Thanks,
> -Jim
> 
> > On Thu, 2002-08-29 at 03:39, Juergen Sawinski wrote:
> > > Changes:
> > > -remove dma reset in stop_{dac,adc}
> > >  (from ICH4 manual: contents of all Bus master related registers to be
> > >   reset; so, probably some registers are not re-initilized properly on
> > >   consecutive re-opening of /dev/dsp ???)
> > > -remove writes to OFF_CIV, instead set LVI relative to CIV
> > > 
> > > and some stuff that was already in the last diff I send to the list:
> > > -implement a codec ID <-> IO register offset mapping
> > > -in i810_ioctl, case SNDCTL_DSP_CHANNELS: only touch bits 20:21
> > >  off GLOB_CNT (multichannel capabilities)
> > > -AMD 8111 has 6 hw channels so I must have mmio (but I don't have
> > >  any docs to verify this)
> > > -minor fixes
-- 
Juergen "George" Sawinski
Max-Planck-Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-309
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 848
Mobile: +49-171-532 5302

