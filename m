Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269092AbRHLLpv>; Sun, 12 Aug 2001 07:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbRHLLpl>; Sun, 12 Aug 2001 07:45:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269092AbRHLLp0>; Sun, 12 Aug 2001 07:45:26 -0400
Subject: Re: Unknown error
To: kaos@ocs.com.au (Keith Owens)
Date: Sun, 12 Aug 2001 12:47:13 +0100 (BST)
Cc: louisg00@bellsouth.net, linux-kernel@vger.kernel.org, device@lanana.org
In-Reply-To: <10497.997601767@ocs3.ocs-net> from "Keith Owens" at Aug 12, 2001 05:36:07 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Vti5-0005ao-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 12 Aug 2001 1:40:01 -0400, 
> <louisg00@bellsouth.net> wrote:
> >I'm running kernel-2.4.8-ac1 on RH beta and I'm this:
> >
> >modprobe: modprobe: Can't locate module char-major-226
> >Did I forget a to compile a module?
> 
> 2.4.8 says that device 228 is unassigned, but ...
> 
>   drivers/char/drm/drm.h:#define DRM_MAJOR       226
>   drivers/net/wan/sdla_chdlc.c:#define WAN_TTY_MAJOR 226
> 
> Somebody has been naughty and used a code not assigned to them.

The 2.4.8 tables are _completely_ out of date. 

The up to date tables say:

226 char        Direct Rendering Infrastructure (DRI)
                  0 = /dev/dri/card0		First graphics card
                  1 = /dev/dri/card1            Second graphics card 


Peter - was this dual issued, or do Sangoma need to be spanked. The obvious
place to put the sdla tty would I think be 229, since its not physically
possible to put one in an iSeries machine.
