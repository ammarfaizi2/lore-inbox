Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbQKFRo4>; Mon, 6 Nov 2000 12:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbQKFRoq>; Mon, 6 Nov 2000 12:44:46 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:50932 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129555AbQKFRoa>;
	Mon, 6 Nov 2000 12:44:30 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <00110617370400.24534@dax.joh.cam.ac.uk> 
In-Reply-To: <00110617370400.24534@dax.joh.cam.ac.uk>  <00110616471600.01646@dax.joh.cam.ac.uk> <23007.973524894@redhat.com> <6786.973530532@redhat.com> 
To: "James A. Sutherland" <jas88@cam.ac.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 17:44:08 +0000
Message-ID: <10507.973532648@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jas88@cam.ac.uk said:
>  Except this isn't possible with the hardware in question! If it were,
> there would be no problem. In cases where the hardware doesn't support
> the functionality userspace "needs", why put the kludge in the kernel?

> If userspace wants to know what settings it set last time, it should
> store those values somewhere.

No. You have to reset the hardware fully each time you load the module. 
Although you _expect_ it to be in the state in which you left it, you can't 
be sure of that. 


jas88@cam.ac.uk said:
> Eh? You just load the driver once, probably on boot, to configure sane
> values. This time round, you use an argument (or an ioctl or whatever)
> to specify the values you want. (cat /etc/sysconfig/sound/
> defaultvolume > /dev/sound/mixer or whatever). After that, the module
> can be unloaded and loaded as needed, without any need to touch the
> mixer settings except in response to *explicit* "set volume" commands
> from userspace. 

Agreed. Where 'whatever' == persistent storage of some form. I care not 
what form that takes. If you can store the data entirely in userspace and 
still have them present at the time the driver initialises the hardware, 
that's fine. 


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
