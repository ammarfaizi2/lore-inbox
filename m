Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTATJcx>; Mon, 20 Jan 2003 04:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbTATJcx>; Mon, 20 Jan 2003 04:32:53 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45330
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264610AbTATJcv>; Mon, 20 Jan 2003 04:32:51 -0500
Date: Mon, 20 Jan 2003 01:37:53 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Sebastian Zimmermann <S.Zimmermann@tu-harburg.de>
cc: "Juergen \"George\"    Sawinski" <george@mpimf-heidelberg.mpg.de>,
       "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: Promise SuperTrak SX6000 w/ kernel 2.4.20
In-Reply-To: <1043055372.1132.7.camel@antares.et6.tu-harburg.de>
Message-ID: <Pine.LNX.4.10.10301200137150.12087-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try the Alan Cox patch set.
I should have fixed the mess introduced in 2.4.19 by the OEM vendor.

On 20 Jan 2003, Sebastian Zimmermann wrote:

> Am Don, 2003-01-16 um 12.23 schrieb Juergen "George" Sawinski:
> > It shouldn't find /dev/hde ... /dev/hdj (there's some problem with the
> > detection mechanism), as these are I2O devices, and thus it's
> > /dev/i2o/hd?. You have to stop the discovery process by adding 
> > 
> > hde=noprobe hdf=noprobe hdg=noprobe hdh=noprobe hdi=noprobe hdj=noprobe
> > 
> > to the lilo append variable.
> 
> Yes, thank you. Now I can boot. (I also had to add /dev/hdm and /dev/hdo
> though.)
> 
> Nonetheless, I still consider this a kernel bug. The kernel should boot
> without the workaround as it did with version 2.4.18.
> 
> Sebastian
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

