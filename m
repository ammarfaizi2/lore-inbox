Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290131AbSAWWCI>; Wed, 23 Jan 2002 17:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290135AbSAWWB7>; Wed, 23 Jan 2002 17:01:59 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:43926
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S290131AbSAWWBp>; Wed, 23 Jan 2002 17:01:45 -0500
Date: Wed, 23 Jan 2002 17:07:13 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: ertzog <ertzog@bk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hot IDE change
Message-ID: <20020123170713.A17310@animx.eu.org>
In-Reply-To: <Pine.LNX.4.21.0201232301090.1053-100000@dial-up-2.energonet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.21.0201232301090.1053-100000@dial-up-2.energonet.ru>; from ertzog on Wed, Jan 23, 2002 at 11:05:19PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This question is more about hardware, but is also related to Linux.
> If I have a harddisk, plugged into the motherboard (IDE cable and power),
> can I turn it off, plugging out first power cable, then IDE cable.
> Can it harm harddisk or motherboard?
> If I can do it, then will Linux detect it back, if I make this 
> operation back: i.e. plug IDE cable, then power cable.

I've read what everyone else has said about this.  The one guy talking about
the pins and power has some good points.  For me, I've always yanked the ide
cable before the power  and made sure the drive was powered and spinning
before applying the ide cable.  I have a machine at work dedicated for this
kind of thing.

anyway, from the linux side, as others have said, make sure it's unmounted. 
On my dedicated box at work, it's nfs mounted and the ide driver is a
module.  I'm always sure to remove the modules before removing the disk.

When compiled in, it's trickier.  the source to hdparm has a script in the
contrib directory that allows you to turn off and back on an ide controller. 
It won't do that if the disk is currently in use.  You have to do this
before it will find another drive (ideally, turning off that channel,
swapping drive, turning back on)  I've used this on my laptop that has a
hotswap cdrom.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
