Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315319AbSDWUDK>; Tue, 23 Apr 2002 16:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315321AbSDWUDJ>; Tue, 23 Apr 2002 16:03:09 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:40200 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S315319AbSDWUDI>; Tue, 23 Apr 2002 16:03:08 -0400
Message-ID: <7425061BF9693F4F8C74BA48F43856900DD5AD@AUSXMPS310.aus.amer.dell.com>
From: Robert_Hentosh@Dell.com
To: m.knoblauch@TeraPort.de, robert@exchange.dell.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] reboot=bios is invalidating cache incorrectly
Date: Tue, 23 Apr 2002 15:02:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin Knoblauch [mailto:Martin.Knoblauch@TeraPort.de]
> Sent: Tuesday, April 23, 2002 8:51 AM
> Subject: Re: [PATCH] reboot=bios is invalidating cache incorrectly
> 
> 
> > [PATCH] reboot=bios is invalidating cache incorrectly
> > 
> > 
> > This patch applies cleanly to 2.4.18 and 2.5.8. It probably 
> also works
> > with all 2.2.x, 2.4.x and 2.5.x kernels.
> > 
> > This fixes a long standing bug that prevented reliable 
> reboots on some
> > platforms.
> > 
> Robert,
> 
>  care to specify which platforms? :-) I ask because I am experiencing
> reboot hangs between BISO and lilo on Tyan 2462 boards. Apparently
> others see similar things.
> 

Martin,

I only have extensive experience with Dell's Server platforms.  But because
of the nature of the error, it can happen on any platform using reboot=bios.

On the platforms I was debugging.. invalidating the cache left a bunch of
ADD's in memory followed by a JMP to itself.  So you would see the message
"rebooting system" but then you would never get a blank screen and BIOS
posting (the reboot vector was never called).

- Robert
