Return-Path: <linux-kernel-owner+w=401wt.eu-S1751484AbXAHMKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbXAHMKy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXAHMKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:10:54 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:33880 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbXAHMKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:10:54 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH UPDATED 2.6.20-rc3] Remove all the unneeded k[mzc]alloc casts
Date: Mon, 8 Jan 2007 13:10:19 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20070105102623.GB382@Ahmed>
In-Reply-To: <20070105102623.GB382@Ahmed>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2083160.AkAySSpq7A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701081310.46547.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2083160.AkAySSpq7A
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ahmed S. Darwish wrote:
> Hi all,
> This is a patch to remove the unneeded k[mzc]alloc casts in the whole
> 2.6.20-rc3 tree. I tried to put this patch in a patchset but I couldn't
> cause the modified files have nothing in common (except the unneeded casts
> ofcourse).
>
> This patch includes http://lkml.org/lkml/fancy/2007/1/5/12 and
> http://lkml.org/lkml/2007/1/5/6.
>
> Signed-off-by: Ahmed Darwish
>
> diff --git a/arch/cris/arch-v32/mm/intmem.c
> b/arch/cris/arch-v32/mm/intmem.c index 41ee7f7..acb4e21 100644
> --- a/arch/cris/arch-v32/mm/intmem.c
> +++ b/arch/cris/arch-v32/mm/intmem.c
> @@ -27,8 +27,8 @@ static void crisv32_intmem_init(void)
>  {
>  	static int initiated = 0;
>  	if (!initiated) {
> -		struct intmem_allocation* alloc =
> -		  (struct intmem_allocation*)kmalloc(sizeof *alloc, GFP_KERNEL);
> +		struct intmem_allocation* alloc = kmalloc(sizeof *alloc,
> +							  GFP_KERNEL);
sizeof(*alloc) (see Documentation/CodingStyle)

There are some more of this kind.

Eike

--nextPart2083160.AkAySSpq7A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFojTGXKSJPmm5/E4RAi4wAKCIzjTyJZYWPXZFPfJ+bNO0ozahjQCfXfZ4
XTfnJ+ohBOXaba1NaPm6nG4=
=cbEX
-----END PGP SIGNATURE-----

--nextPart2083160.AkAySSpq7A--
