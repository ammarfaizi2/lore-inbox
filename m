Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261380AbTC0V2L>; Thu, 27 Mar 2003 16:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261381AbTC0V2L>; Thu, 27 Mar 2003 16:28:11 -0500
Received: from kknd.mweb.co.za ([196.2.45.79]:55481 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id <S261380AbTC0V2J>;
	Thu, 27 Mar 2003 16:28:09 -0500
Date: Thu, 27 Mar 2003 23:39:02 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Walt H <waltabbyh@comcast.net>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: vesafb problem
Message-Id: <20030327233902.5963b0b1.bonganilinux@mweb.co.za>
In-Reply-To: <3E835241.9060407@comcast.net>
References: <3E8329D2.7040909@comcast.net>
	<20030327190222.GA4060@middle.of.nowhere>
	<3E835241.9060407@comcast.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.CtCrZP.+9?zGbs"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.CtCrZP.+9?zGbs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2003 11:34:25 -0800
Walt H <waltabbyh@comcast.net> wrote:

> Jurriaan wrote:
> 
> > 
> > I had a similar problem with 1 Gb Ram, and received this answer on the
> > linux-kernel mailinglist:

<sip>

> >     thunder7> framebuffer just fine (well, it doesn't work and writes
> >     thunder7> funky patters to the screen, but at least
> >     thunder7> ioremap_nocache() works fine).
> > 
> >     thunder7> What is the reason ioremap_nocache() fails? Is this
> >     thunder7> something that can be prevented? I am not entirely clear
> >     thunder7> on what is happening anyway (real memory, virtual
> >     thunder7> memory, nocache-memory, io-memory - a little bit above

<snip>

> > This means with "mem=512M", you will probably have about 500M of
> > vmalloc space, which is more than enough to ioremap the framebuffer.
> > 

<snip>

> > To see if this is it, booting with mem=512M would be a good test.
> > 
> > Kind regards,
> > Jurriaan
> 
> Thanks for the reply. That is indeed what is doing it. When I added 
> mem=512M, I had two smiling penguins on boot :)  My vid card does have 
> 128MB Ram, but I also tend to agree that I'm not sure that the 
> framebuffer needs to remap *all* of its memory. But, for now, I think 
> I'll add the hack (256 << 20) to make it work. Any ideas if this might 
> have unforseen bad effects? Might it screw up highmem I/O? Thanks again,
> 
> -Walt


Strange I'm having the same problem, but I only have 256MB of memory and my GeForce 2 only has 32MB. This is what's on my messages file:


vesafb: framebuffer at 0xe0000000, mapped to 0xd0807000, size 32768k
vesafb: mode is 800x600x16, linelength=1600, pages=3
vesafb: protected mode interface info at c000:c060
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Looking for splash picture.... found (800x600, 13683 bytes).
Console: switching to colour frame buffer device 82x30
fb0: VESA VGA frame buffer device


--=.CtCrZP.+9?zGbs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+g2+A+pvEqv8+FEMRAvAeAKCeNrVUm33saVax/80XsUnrCMie1wCgjkW9
K0284ca8QrfHvZ7mElHayi0=
=5JkB
-----END PGP SIGNATURE-----

--=.CtCrZP.+9?zGbs--
