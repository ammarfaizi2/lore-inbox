Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbSLKKJ2>; Wed, 11 Dec 2002 05:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267105AbSLKKJ2>; Wed, 11 Dec 2002 05:09:28 -0500
Received: from [217.167.51.129] ([217.167.51.129]:61638 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267104AbSLKKJ1>;
	Wed, 11 Dec 2002 05:09:27 -0500
Subject: Re: Linux 2.5.51
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James Simmons <jsimmons@infradead.org>, Stian Jordet <liste@jordet.nu>,
       Allan Duncan <allan.d@bigpond.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m1smx4vrem.fsf@frodo.biederman.org>
References: <Pine.LNX.4.33.0212101016280.2617-100000@maxwell.earthlink.net>
	<1039547936.538.5.camel@zion>  <m1smx4vrem.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Dec 2002 11:21:12 +0100
Message-Id: <1039602072.3539.42.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 10:25, Eric W. Biederman wrote:
> > Well, I'm not sure it quite works yet. Maybe unaccelerated, but anyway,
> > my version of radeonfb for 2.5 isn't accelerated yet anyway. I'll work
> > on that (or Ani will) now that the API is stable enough.
> 
> How well does this driver work if you don't have a firmware
> driver initialize the card? aka a pci option ROM.

Probably not at all
 
> I am interested because with LinuxBIOS it is still a pain to run
> PCI option roms, and I don't necessarily even have then if it a
> motherboard with video.  There are some embedded/non-x86 platforms
> with similar issues.  

Well, at least r128's and radeon's need the memory controller and PLLs
initialized by the BIOS/firmware, we don't have documentation about how
to acheive that ourselves (and this can depend on the specific wiring of
a given card anyway).

> My primary interest is in the cheap ATI Rage XL chip that is on many
> server board. PCI Vendor/device  id 1002:4752 (rev 27) from lspci.
> 
> If nothing else if some one could point me to some resources on
> how to get the appropriate documentation from the video chipset
> manufacturers I would be happy.
> 
> But I did want to at least point that running a system with out bios
> initialized video was certainly among the cases that are used.

This is not possible with most modern cards without specific POST code
provided by the chip manufacturer.

Ben.

