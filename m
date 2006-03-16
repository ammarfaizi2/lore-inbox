Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751987AbWCPBaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbWCPBaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbWCPBaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:30:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54279 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751987AbWCPBaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:30:16 -0500
Date: Thu, 16 Mar 2006 02:30:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: mdharm-usb@one-eyed-alien.net, usb-storage@lists.one-eyed-alien.net,
       linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: [v4l-dvb-maintainer] 2.6.16-rc: saa7134 + usb-storage = freeze
Message-ID: <20060316013004.GA3914@stusta.de>
References: <20060315185152.GA4454@stusta.de> <1142454448.4666.44.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142454448.4666.44.camel@praia>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 05:27:28PM -0300, Mauro Carvalho Chehab wrote:
> Adrian,
> 	hmm... VIA vt8237... We have several similar reports with current VIA
> chipsets (KT800 and KT880) and PCI2PCI transfers (Overlay mode in
> xawtv). Would you please download the latest Mercurial development tree
> at 
> http://linuxtv.org/hg/v4l-dvb and try modprobing saa7134 with the insmod
> option no_overlay=1.
>...

"Capture: grabdisplay" in xawtv seems to fix the problem.
I'll do some further tries whether this was only luck.

I don't know whether it's related, but xawtv sometimes spits warnings 
like the following (independent of whether the USB disk is plugged in):

ioctl: VIDIOC_TRY_FMT(type=VIDEO_OVERLAY;fmt.win.w.left=306;fmt.win.w.top=191;fmt.win.w.width=43;fmt.win.w.height=35;fmt.win.field=ANY;fmt.win.chromakey=0;fmt.win.clips=(nil);fmt.win.clipcount=0;fmt.win.bitmap=(nil)): Invalid argument
ioctl: VIDIOC_S_FMT(type=VIDEO_OVERLAY;fmt.win.w.left=306;fmt.win.w.top=192;fmt.win.w.width=43;fmt.win.w.height=32;fmt.win.field=ANY;fmt.win.chromakey=0;fmt.win.clips=0x80c9a04;fmt.win.clipcount=0;fmt.win.bitmap=(nil)): Invalid argument
ioctl: VIDIOC_TRY_FMT(type=VIDEO_OVERLAY;fmt.win.w.left=306;fmt.win.w.top=191;fmt.win.w.width=43;fmt.win.w.height=35;fmt.win.field=ANY;fmt.win.chromakey=0;fmt.win.clips=(nil);fmt.win.clipcount=0;fmt.win.bitmap=(nil)): Invalid argument
ioctl: VIDIOC_S_FMT(type=VIDEO_OVERLAY;fmt.win.w.left=306;fmt.win.w.top=192;fmt.win.w.width=43;fmt.win.w.height=32;fmt.win.field=ANY;fmt.win.chromakey=0;fmt.win.clips=0x80c9a04;fmt.win.clipcount=0;fmt.win.bitmap=(nil)): Invalid argument
ioctl: VIDIOC_OVERLAY(int=0): Invalid argument
ioctl: VIDIOC_DQBUF(index=0;type=VIDEO_CAPTURE;bytesused=0;flags=0x0 [];field=ANY;;timecode.type=0;timecode.flags=0;timecode.frames=0;timecode.seconds=0;timecode.minutes=0;timecode.hours=0;timecode.userbits="";sequence=0;memory=unknown): Input/output error

> Cheers, 
> Mauro.
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

