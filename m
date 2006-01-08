Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752647AbWAHRdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbWAHRdx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbWAHRdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:33:53 -0500
Received: from mx2.mail.ru ([194.67.23.122]:13096 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1752647AbWAHRdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:33:52 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Dave Jones <davej@redhat.com>
Subject: Re: cpufreq on Toshiba Portege 4000?
Date: Sun, 8 Jan 2006 20:33:47 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200508012156.18271.arvidjaar@mail.ru> <20050801180639.GA8530@redhat.com>
In-Reply-To: <20050801180639.GA8530@redhat.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601082033.48520.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 01 August 2005 22:06, Dave Jones wrote:
> On Mon, Aug 01, 2005 at 09:56:17PM +0400, Andrey Borzenkov wrote:
>  > Toshiba documentation claims it supports speedstep technology. It has
>  > Ali chipset and PIII CPU:
>  >
>  > {pts/1}% lspci
>  > 00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident
>  > (rev 01) 00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
>  > 00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
>  > 00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
>  > ...
>  >
>  > Any cnahce to use cpufreq (or compatible) technique here?
>
> Nope, The speedstep-smi driver only works on Intel chipsets.
>

well, acpi-cpufreq appears to work here. The only drawback is that BIOS 
supports only 2 states (750 and 500MHz) while Toshiba HCI interface can 
switch between 8 levels; unfortunately I have no idea what frequencies they 
have.

Is there any utility to measure actual CPU frequency? If I can determine real 
speed, I could try extend DSDT to support other levels too.

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDwUz8R6LMutpd94wRApWiAKDHggfFN34VTPrC3ABsQO6SY9FztQCeJQCJ
aWYCZX6k117FqtdVsY16UVQ=
=84r3
-----END PGP SIGNATURE-----
