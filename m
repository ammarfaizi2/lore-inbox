Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310453AbSCPRVn>; Sat, 16 Mar 2002 12:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310457AbSCPRVd>; Sat, 16 Mar 2002 12:21:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58888 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310453AbSCPRVV>; Sat, 16 Mar 2002 12:21:21 -0500
Subject: Re: [PATCH] devexit fixes in i82092.c
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 16 Mar 2002 17:35:54 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        andersg@0x63.nu (Anders Gustafsson), arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <3C930785.2070902@mandrakesoft.com> from "Jeff Garzik" at Mar 16, 2002 03:51:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mI5y-0006ls-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If it makes it easier for some, I consider poweroff not as an act unto 
> itself, but as a transition to state D3cold. :)  And since we will 

That isnt neccessarily a good idea. Not every BIOS is terribly keen when
faced with a soft boot and someone having powered off all the PCI bridges.

> >This is what I want. Those reboot/shutdown notifiers are completely and 
> >utterly buggy, and cannot sanely handle any kind of device hierarchy.
> >
> yep

They were never designed to. They should go - the new PM code can handle
everything they do, including refusals and more. It will also fix the ordering 
problems some people hit with them.

Alan

