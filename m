Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423600AbWKFIUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423600AbWKFIUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 03:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423603AbWKFIUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 03:20:01 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:53212 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1423600AbWKFIUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 03:20:00 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/8] Char: istallion, convert to pci probing
Date: Fri, 3 Nov 2006 19:19:45 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <17413142092390932669@wsc.cz>
In-Reply-To: <17413142092390932669@wsc.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart129188314.B7GBZj7ETd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611031919.45391.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart129188314.B7GBZj7ETd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jiri Slaby wrote:
> istallion, convert to pci probing
>
> Use probing for pci devices. Change some __inits to __devinits to use these
> functions in probe function. Create stli_cleanup_ports and move there
> cleanup code from module_exit() code to not have duplicite cleanup code.
>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>
> ---
> commit b90798585707a33d1835b752a18f1ca3b6a7da7b
> tree 7c99e2bcca81b25dc3ffdcf288b5a9c35433c098
> parent 7e8fb7980d776e6a7c0bd84cc48b1cb9de139b8f
> author Jiri Slaby <jirislaby@gmail.com> Sun, 29 Oct 2006 23:37:48 +0100
> committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 18:26:39 +0059
>
>  drivers/char/istallion.c |  116
> +++++++++++++++++++++++++++------------------- 1 files changed, 67
> insertions(+), 49 deletions(-)
>
> diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
> index f07716b..9e73d0d 100644
> --- a/drivers/char/istallion.c
> +++ b/drivers/char/istallion.c
> @@ -402,7 +402,6 @@ static int	stli_eisamempsize = ARRAY_SIZ
>  /*
>   *	Define the Stallion PCI vendor and device IDs.
>   */
> -#ifdef CONFIG_PCI
>  #ifndef	PCI_VENDOR_ID_STALLION
>  #define	PCI_VENDOR_ID_STALLION		0x124d
>  #endif

Remove that ifdef and define too. We _have_ the id in include/linux/pci_ids.h

Eike

--nextPart129188314.B7GBZj7ETd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFS4hBXKSJPmm5/E4RAvtYAJ9jgVTxOIVK4XtoDbTqVX8yMf73DQCeIxYf
3Ofl/x5A6nR91rufw1Vkwx8=
=U/mr
-----END PGP SIGNATURE-----

--nextPart129188314.B7GBZj7ETd--
