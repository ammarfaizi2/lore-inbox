Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262011AbREQQcn>; Thu, 17 May 2001 12:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbREQQce>; Thu, 17 May 2001 12:32:34 -0400
Received: from [206.14.214.140] ([206.14.214.140]:62727 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S262011AbREQQcZ>; Thu, 17 May 2001 12:32:25 -0400
Date: Thu, 17 May 2001 09:26:27 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E150BXx-0004js-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10105170902110.13202-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > USB disks are required (haha etc) to have serial numbers. Firewire similarly
> > > has unique disk identifiers.
> > 
> > How about for other device classes?
> 
> Keyboards and mice dont which is a real pig because it prevents you using
> dual head, two usb keyboards and 2 usb mice for a dual user box (assuming
> someone fixed the console code mess to cope with multiple console users as
> a concept)

Wrong!! I already have a multi-desktop system running at home. I have two
PS/2 keyboards, Sun keyboard, and a USB keyboard hooked up to my system. I
only have two monitors/video cards so I only have two VTs going at the
same time. I even managed to get two X servers running on each VT
independent of each other. This was not ease but it is possible. 
   I can tell you I didn't use any type of id system. How do I deal with
devices like multiple sound cards (yes I have that too) in a multidesktop
environment? With file permission on the device nodes. I created
different groups for different desktops. With a little tweaking with PAM
when I login to a specific workstation I'm automatically added to a
certain desktop group. I can't access any devices that belong to another 
desktop group. When I logout I'm removed from that group. Now xdm needs a
little hacking to make this work. 
   The beauty of this approach is the admin determines which devices
belong to which desktop. Now for hotpluggable devices when they plugged
back in a device they just unplugged and they don't end up on the same
device that new device will belong to no one. They can use some userland
utility then to grab the device. In this case it is first come first
serve. Surely when you plug in your device you are NOT going to steal a
device in use but one that is avaliable. Now what if two people unplug
their mice at the same time and plug them back in and they are mixed up.
Again I think a userland utility can solve this problem. Here you would
need to be root to fix the problem. 

