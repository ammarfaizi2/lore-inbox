Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTKTJ71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 04:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTKTJ71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 04:59:27 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:5060 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261376AbTKTJ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 04:59:25 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Announce: ndiswrapper
Date: Thu, 20 Nov 2003 10:56:37 +0100
User-Agent: KMail/1.5.4
Cc: Nick Piggin <piggin@cyberone.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC402E.6070109@cyberone.com.au> <20031120043848.GG19856@holomorphy.com>
In-Reply-To: <20031120043848.GG19856@holomorphy.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311201057.07503.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

On Thursday 20 November 2003 05:38, William Lee Irwin III wrote:
> It's very much a second-class flavor of open source. They dare not
> change the kernel version lest the binary-only trainwreck explode.

We already have a second-class flavor of open source in the kernel right
now. There are drivers that do "magic value at magic address" in a quite
sophisticated manner. Combine this with firmware load from Windows DLLs
and you basically HAVE closed source, since the driver is on the device
itself and we just invoke it via i2c commands.

On NVidia drivers we might complain, that we don't see, which kernel
functions are used and for what. On these drivers we don't even see what
is done, since the device can issue DMA at will and thus scribble over
random kernel memory on firmware malfunction. And maybe this scribbling
is not that lethal to Windows for some reasons (e.g. area never used or
reserved area) so it will never be fixed.

Just have a look at some DVB hardware drivers. As much as I like *what*
is done there, I don't like how it is done.

What you call second-class is third-class already, since it also freezes
the kernel ABI and behavior forcably.

> They dare not run with the whiz-bang patches going around they're
> interested in lest the binary-only trainwreck explode. It may oops
> in mainline, and all they can do is wait for a tech support line to
> answer. Well, they're a little better than that, they have hackers
> out and about, but you're still stuck waiting for a specific small
> set of individuals and lose all of the "many eyes" advantages.

This "many eye" advantage is lost already by the type of drivers above
in kernel right now. Binary-only just adds to the pain by freezing
kernel<->module ABI.

Regards

Ingo Oeser


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/vI/xU56oYWuOrkARAubfAJ4kIKlQvGbnPHxebnEQrqcfxOxMzQCeJ1Rz
jZ4toSAkd4Ry1LXNReuh2dc=
=zfYZ
-----END PGP SIGNATURE-----

