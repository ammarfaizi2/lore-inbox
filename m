Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032233AbWLGNyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032233AbWLGNyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032232AbWLGNyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:54:09 -0500
Received: from mivlgu.ru ([81.18.140.87]:53820 "EHLO mail.mivlgu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032234AbWLGNyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:54:08 -0500
Date: Thu, 7 Dec 2006 16:53:52 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Daniel Ritz <daniel.ritz@gmx.ch>,
       Daniel Drake <dsd@gentoo.org>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-Id: <20061207165352.9cb61023.vsu@altlinux.ru>
In-Reply-To: <20061207132430.GF8963@stusta.de>
References: <20061207132430.GF8963@stusta.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__7_Dec_2006_16_53_52_+0300_9YF5kd/oK/OYvCvr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__7_Dec_2006_16_53_52_+0300_9YF5kd/oK/OYvCvr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2006 14:24:30 +0100 Adrian Bunk wrote:

> While checking how to fix the VIA quirk regressions for several users
> introduced into -stable in 2.6.16.17, I started looking through all
> drivers/pci/quirks.c updates up to both -stable and 2.6.19.
>
> Below is the selection the seemed good and safe.
>
> Any comments on whether it's really good or whether I should change
> anything?
>
> TIA
> Adrian
>
>
> Bauke Jan Douma (1):
>       PCI: quirk for asus a8v and a8v delux motherboards

This quirk will cause breakage for people who used an external PCI
soundcard with these boards - the builtin sound chip which was
invisible before may become the first audio device.

It also enables the MC97 device, which does not really work (there is
no MC97 codec attached to the controller at least on A8V Deluxe; I'm
not sure if there is some other variant of this board which has MC97,
but it seems unlikely).

[...]

--Signature=_Thu__7_Dec_2006_16_53_52_+0300_9YF5kd/oK/OYvCvr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFeBz0W82GfkQfsqIRAiMjAJ0QTZUcOw8v1YHwE05Rb+kp9TVb0ACghmmm
zUX2tbonfBADS6n26GSmkS0=
=6CSd
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Dec_2006_16_53_52_+0300_9YF5kd/oK/OYvCvr--
