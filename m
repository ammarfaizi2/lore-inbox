Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269946AbRHMHs2>; Mon, 13 Aug 2001 03:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269964AbRHMHsS>; Mon, 13 Aug 2001 03:48:18 -0400
Received: from 20dyn53.com21.casema.net ([213.17.90.53]:1552 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S269946AbRHMHsI>; Mon, 13 Aug 2001 03:48:08 -0400
Message-Id: <200108121955.VAA25314@cave.bitwizard.nl>
Subject: Re: Unknown error
In-Reply-To: <E15Vti5-0005ao-00@the-village.bc.nu> from Alan Cox at "Aug 12,
 2001 12:47:13 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 12 Aug 2001 21:55:45 +0200 (MEST)
CC: Keith Owens <kaos@ocs.com.au>, louisg00@bellsouth.net,
        linux-kernel@vger.kernel.org, device@lanana.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > 2.4.8 says that device 228 is unassigned, but ...
> > 
> >   drivers/char/drm/drm.h:#define DRM_MAJOR       226
> >   drivers/net/wan/sdla_chdlc.c:#define WAN_TTY_MAJOR 226
> > 
> > Somebody has been naughty and used a code not assigned to them.

> 226 char        Direct Rendering Infrastructure (DRI)
>                   0 = /dev/dri/card0		First graphics card
>                   1 = /dev/dri/card1            Second graphics card 
> 
> 
> Peter - was this dual issued, or do Sangoma need to be spanked. The obvious
> place to put the sdla tty would I think be 229, since its not physically
> possible to put one in an iSeries machine.

Speaking of which... 

I always (try to) write my drivers to do:

#ifndef MY_MAJOR
#define MY_MAJOR xyz
#endif

This allows "test-compilation" with -Dtest_major , but is also
preparing for having a "majors.h" which defines ALL the major numbers
in one place. The place where it /completly/ obvious if two devices
are trying to use the same major.... 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
