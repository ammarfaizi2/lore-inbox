Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUHPMLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUHPMLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUHPMLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:11:38 -0400
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:37015 "HELO
	qinetiq-tim.net") by vger.kernel.org with SMTP id S266133AbUHPMLg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:11:36 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: High CPU usage (up to server hang) under heavy I/O load
Date: Mon, 16 Aug 2004 13:10:14 +0100
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040813140229.4F48B2FC2C@illicom.com> <200408161013.13829.m.watts@eris.qinetiq.com> <1092653845.20528.3.camel@localhost.localdomain>
In-Reply-To: <1092653845.20528.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408161310.14300.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.11; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Llu, 2004-08-16 at 10:13, Mark Watts wrote:
> > Would this also mean that if I stick a 64bit SATA raid card (a 3Ware
> > 8506-4LP in this case) into a 32bit pci slot, then I/O is always going to
> > suck badly?
> >
> > ... cos I do, and I/O sucks :)
>
> Seperate issue.
>
> 64bit DMA is 64bit addressing (ie can DMA from above 4GB). 64bit wide
> slot is double the speed for transfers. The 3ware 8xxx I thought could
> do 64bit addressing although the driver seems to indicate it cannot,
> so with over 4Gb it would hurt.

We're running Dual Opterons (Tyan S2875 boards) with 2GB ram.
These boards only have 32bit pci slots so we're already not using the full 
potential of the 3Ware.
Basically write performance is a major bottleneck (hardware raid-5 with 250GB 
sata drives) and writing anything over a few meg usually causes the machine 
to stall while the write occurs.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBIKQmBn4EFUVUIO0RAjZ3AKDctamutj48XLKCMbY4FSfwgjtXEwCdGHPX
bvvd3PNk3SlilysaOYtwa6Y=
=rOlr
-----END PGP SIGNATURE-----
