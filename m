Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317122AbSFFSr6>; Thu, 6 Jun 2002 14:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSFFSq2>; Thu, 6 Jun 2002 14:46:28 -0400
Received: from air-2.osdl.org ([65.201.151.6]:29069 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317110AbSFFSqE>;
	Thu, 6 Jun 2002 14:46:04 -0400
Date: Thu, 6 Jun 2002 11:41:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 tulip bogosities
In-Reply-To: <3CFFAA8D.8000106@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0206061139111.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Jun 2002, Jeff Garzik wrote:

> Mikael,
> 
> Can you try an experiment for me?
> 
> Run 2.5.19 with the 2.5.20 tulip.  Just copy drivers/net/tulip/* from 
> 2.5.20 into 2.5.19.
> 
> Nothing changed in 2.5.20 tulip that should cause that, AFAICS.  So I 
> want to narrow down the problem before looking further.

There was a bug in the PCI code that only passed the first device ID the 
driver supported to the driver's probe callback. It caused a few other 
oddities. A patch was posted to the list:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102316813812289&w=2

and is now in Linus' tree. It should fix the problem, if you get a chance 
to test it...

	-pat

