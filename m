Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318868AbSHEUPW>; Mon, 5 Aug 2002 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318872AbSHEUPV>; Mon, 5 Aug 2002 16:15:21 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:63146 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318868AbSHEUPS>; Mon, 5 Aug 2002 16:15:18 -0400
Subject: Re: i810 sound broken...
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <1028552057.18130.6.camel@irongate.swansea.linux.org.uk>
References: <200208051127.g75BRgX27554@eday-fe5.tele2.ee> 
	<1028552057.18130.6.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Aug 2002 22:21:00 +0200
Message-Id: <1028578861.1894.15.camel@voyager>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my Intel D845GBV board (obviously ICH4) none of 2.4 nor alsa works.
It's a production box, so I hestitate to try 2.5.

George

P.S.: Alan, any hints how I can examine/fix this?


On Mon, 2002-08-05 at 14:54, Alan Cox wrote:
> On Mon, 2002-08-05 at 12:27, Thomas Munck Steenholdt wrote:
> > I've noticed some writing on lkml on how i810(AC97) sound was broken. 
> > Aparantly a couple of fixes have been posted, but I couldn't see
> > where(if at all) those patches have gone... 2.4.19 still does not work
> > and 2.4.19-ac3 won't even load the i810 module.
> > 
> > Does anybody know if the known i810 sound issue has, in fact, been fixed, and if so - in what kernel/patch?
> 
> Its working nicely for me in 2.4.19 and 2.4.19-ac1. The 2.4.19-ac3 tree
> has a bug in pci_enable_device which will stop it working if built with
> some compilers (by chance it works ok the way I tested it). Thats fixed
> in ac4.
> 
> The changes in the recent i810 audio are
> - Being more pessimistic in our interpretation of codec power up
> - Turning on EAPD in case the BIOS didn't do so at boot up
> 
> Longer term full EAPD control as we do with the cs46xx is on my list,
> paticularly as i8xx laptops are becoming common . (EAPD is the amplifier
> power controller)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Juergen Sawinski
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

