Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318381AbSHELcH>; Mon, 5 Aug 2002 07:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318384AbSHELcH>; Mon, 5 Aug 2002 07:32:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1277 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318381AbSHELcG>; Mon, 5 Aug 2002 07:32:06 -0400
Subject: Re: i810 sound broken...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Munck Steenholdt <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208051127.g75BRgX27554@eday-fe5.tele2.ee>
References: <200208051127.g75BRgX27554@eday-fe5.tele2.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 13:54:17 +0100
Message-Id: <1028552057.18130.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 12:27, Thomas Munck Steenholdt wrote:
> I've noticed some writing on lkml on how i810(AC97) sound was broken. 
> Aparantly a couple of fixes have been posted, but I couldn't see
> where(if at all) those patches have gone... 2.4.19 still does not work
> and 2.4.19-ac3 won't even load the i810 module.
> 
> Does anybody know if the known i810 sound issue has, in fact, been fixed, and if so - in what kernel/patch?

Its working nicely for me in 2.4.19 and 2.4.19-ac1. The 2.4.19-ac3 tree
has a bug in pci_enable_device which will stop it working if built with
some compilers (by chance it works ok the way I tested it). Thats fixed
in ac4.

The changes in the recent i810 audio are
- Being more pessimistic in our interpretation of codec power up
- Turning on EAPD in case the BIOS didn't do so at boot up

Longer term full EAPD control as we do with the cs46xx is on my list,
paticularly as i8xx laptops are becoming common . (EAPD is the amplifier
power controller)

