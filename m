Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSGZJ3F>; Fri, 26 Jul 2002 05:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSGZJ3E>; Fri, 26 Jul 2002 05:29:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:29684 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317433AbSGZJ3E>; Fri, 26 Jul 2002 05:29:04 -0400
Subject: Re: [PATCH] IDE 104
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D411134.60904@evision.ag>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>	
	<3D40F8F9.1050507@evision.ag>
	<1027678411.13428.3.camel@irongate.swansea.linux.org.uk> 
	<3D411134.60904@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 11:46:30 +0100
Message-Id: <1027680390.13428.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 10:07, Marcin Dalecki wrote:
> The only thing which is really 'external API' there is the declaration
> of the HDIO_XXX ioctl and among them in reality only HDIO_GETGEO 
>       is really used outside the scope of the dreddy hdparm application. 
> And
> 99% of times its usage is bogous anyway. Or do you know any better
> examples I'm not aware of?

The struct hd_geometry is used by ioctl HDIO_GETGEO. 
The struct hd_driveid is used by ioctl HDIO_GETIDENTITY

> The remainings will be moved away from there soon becouse it doesn't
> make any sense to include this at every single place out there where
> HDIO_GETGEO is the needed declaration. If some application needs ATA 

This would be great, right now lots of drivers suck in the file for the 
GETGEO stuff even though they are nothing to do with st506 or ide.

Alan

