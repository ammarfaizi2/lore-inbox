Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265944AbUFTUti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUFTUti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUFTUti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 16:49:38 -0400
Received: from handhelds.org ([192.58.209.91]:52627 "EHLO handhelds.org")
	by vger.kernel.org with ESMTP id S265944AbUFTUtf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 16:49:35 -0400
From: Joshua Wise <joshua@joshuawise.com>
Organization: JoshuaWise.com DevStudios
To: Ian Molton <spyro@f2s.com>
Subject: Re: DMA API issues... summary
Date: Sun, 20 Jun 2004 16:49:33 -0400
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net,
       James.Bottomley@SteelEye.com, greg@kroah.com, tony@atomide.com,
       jamey.hicks@hp.com
References: <1087582845.1752.107.camel@mulgrave> <1087603453.2135.224.camel@mulgrave> <20040619161153.3be26806.spyro@f2s.com>
In-Reply-To: <20040619161153.3be26806.spyro@f2s.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406201649.34953.joshua@joshuawise.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jumping into the discussion from the middle of nowhere ......

> Single chip devices may be able to either access system memory directly, or
> may only be able to access their internal SRAM pool. in the case of the
> latter the system can either directly access the SRAM or not, depending on
> the device/bus setup. Its possible the devices may have more than one
> non-continuous SRAM mapping.
>
> The same goes for SOC devices, however they could come in two 'classes'. In
> one type, we would essentially have multiple independant devices in a
> single chip. In another case (which appears to be fairly common) we can
> have multiple devices sharing a common SRAM pool. its also possible to have
> some devices sharing the pool and some having their own in the same chip.

First off ... Why just say the internal SRAM pool? I think it woudl be better 
to say that the devices can only access their own address space, and can only 
DMA from a subset of that (which may be the full original set, QED)

Second... Remember that the SOC can also be the CPU! At least on XScale, there 
are some portions that we can DMA from main memory (I think USB is one).

Of course this might not be at all relevant to the discussion, and of course I 
could be using my rectally-based knowledge, but I _THINK_ that this is 
correct.

joshua
- -- 
Joshua Wise | www.joshuawise.com
GPG Key     | 0xEA80E0B3
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1fhdPn9tWOqA4LMRAuwVAKCq2kcu0V1nnBtZZgwSkTAM2a/izACbBAKu
0ef8cBr9EfxqeYILtdzrgvw=
=B2Yf
-----END PGP SIGNATURE-----
