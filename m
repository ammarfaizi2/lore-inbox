Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSCYTW5>; Mon, 25 Mar 2002 14:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312518AbSCYTWr>; Mon, 25 Mar 2002 14:22:47 -0500
Received: from air-2.osdl.org ([65.201.151.6]:5771 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S312411AbSCYTW2>;
	Mon, 25 Mar 2002 14:22:28 -0500
Date: Mon, 25 Mar 2002 11:19:49 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Anders Gustafsson <andersg@0x63.nu>, <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <E16mI5y-0006ls-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203251116500.3237-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002, Alan Cox wrote:

> > If it makes it easier for some, I consider poweroff not as an act unto 
> > itself, but as a transition to state D3cold. :)  And since we will 
> 
> That isnt neccessarily a good idea. Not every BIOS is terribly keen when
> faced with a soft boot and someone having powered off all the PCI bridges.

You can get around that by creating a PCI bridge driver. There really 
isn't much that you want to do to a bridge anyway, even on power 
transitions. Remove would be simply something like (I think) Jeff 
mentioned later - simply restore config space to it's boot-time 
configuration. 

	-pat


