Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269334AbRHLTkf>; Sun, 12 Aug 2001 15:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269409AbRHLTkQ>; Sun, 12 Aug 2001 15:40:16 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:61705 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269334AbRHLTkM>; Sun, 12 Aug 2001 15:40:12 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Unknown error
Date: 12 Aug 2001 12:40:21 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9l6m35$doc$1@cesium.transmeta.com>
In-Reply-To: <10497.997601767@ocs3.ocs-net> <E15Vti5-0005ao-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E15Vti5-0005ao-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > On Sun, 12 Aug 2001 1:40:01 -0400, 
> > <louisg00@bellsouth.net> wrote:
> > >I'm running kernel-2.4.8-ac1 on RH beta and I'm this:
> > >
> > >modprobe: modprobe: Can't locate module char-major-226
> > >Did I forget a to compile a module?
> > 
> > 2.4.8 says that device 228 is unassigned, but ...
> > 
> >   drivers/char/drm/drm.h:#define DRM_MAJOR       226
> >   drivers/net/wan/sdla_chdlc.c:#define WAN_TTY_MAJOR 226
> > 
> > Somebody has been naughty and used a code not assigned to them.
> 
> The 2.4.8 tables are _completely_ out of date. 
> 
> The up to date tables say:
> 
> 226 char        Direct Rendering Infrastructure (DRI)
>                   0 = /dev/dri/card0		First graphics card
>                   1 = /dev/dri/card1            Second graphics card 
> 
> 
> Peter - was this dual issued, or do Sangoma need to be spanked. The obvious
> place to put the sdla tty would I think be 229, since its not physically
> possible to put one in an iSeries machine.
> 

226 is assigned to DRI.  I don't know anything about an "sdla tty"
unless it is in my post-Linus-prononucement queue, which I have yet to
deal with.

The current list is dated 3 June 2001 (I just noticed it wasn't up on
www.lanana.org; I just fixed that.)  It includes all registrations I
had received up to Linus' "no new majors" pronouncement -- it should
be included in both Linus' and your trees.

http://www.lanana.org/docs/device-list/devices.txt

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
