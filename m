Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290496AbSBKVs0>; Mon, 11 Feb 2002 16:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290520AbSBKVsQ>; Mon, 11 Feb 2002 16:48:16 -0500
Received: from pc-62-31-132-34-mo.blueyonder.co.uk ([62.31.132.34]:43939 "HELO
	gate.mcdee.net") by vger.kernel.org with SMTP id <S290496AbSBKVsI>;
	Mon, 11 Feb 2002 16:48:08 -0500
Subject: Re: "All of your loopback devices are in use!" reported by mkinitrd
From: Jim McDonald <Jim@mcdee.net>
To: amoote@ivhs.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1013461497.806.501.camel@phantasy>
In-Reply-To: <200202111559320446.2581AD39@notes.fpelectronics.com> 
	<1013461497.806.501.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 21:44:46 +0000
Message-Id: <1013463886.1669.239.camel@lapcat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 21:04, Robert Love wrote:
> On Mon, 2002-02-11 at 15:59, Al Moote wrote:
> > Hey all.  I am not-so new to Linux, but I haven't had to recompile my kernel before.  We are taking the leap into Samba Fileserving an thus, I need to add ACL functionality to my kernel.  I have opted to go with 2.4.17 and have had some success so far.  I am, however, stuck at one point.
> > 
> > I am trying to make my .img file to support my RAID devices.  When I run:
> > 
> > /sbin/mkinitrd /boot/initrd-2.4.17-021102.img 2.4.17-021102
> > 
> > I get the message:
> > 
> > All of your loopback devices are in use!
> > 
> > I don't really understand why this is preventing me from creatingthe .img file.  But then again, I have little experience in this area.  I was hoping somebody on this list could len a hand.  Thanks alot guys (and the occasional gal).
> 
> You need loopback support in your kernel, and you probably don't?
> 
> Enable CONFIG_BLK_DEV_LOOP (see Block Devices in configure).

Either that or you've compiled loopback devices directly in to the
kernel this time around, they were modules last time around, and you
have kept the same kernel name.  If you do this the make modules_install
blasts the module from the /lib/modules/2.4.xx and a subsequent mkinitrd
can't load the loopback module.  Check out dmesg to see if this is the
problem.

> 	Robert Love

Cheers,
Jim.
-- 
Jim McDonald - Jim@mcdee.net

