Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVCTTrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVCTTrV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVCTTrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:47:21 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:39136 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261183AbVCTTrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:47:05 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Greg K-H <greg@kroah.com>
Subject: Re: PCI: remove pci_find_device usage from pci sysfs code.
Date: Sun, 20 Mar 2005 15:53:58 +0100
User-Agent: KMail/1.8
References: <11099696382684@kroah.com> <11099696382576@kroah.com>
In-Reply-To: <11099696382576@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1184857.6k3G3EXZuE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503201554.05010.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1184857.6k3G3EXZuE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greg KH wrote:
> ChangeSet 1.1998.11.23, 2005/02/25 08:26:11-08:00, gregkh@suse.de
>
> PCI: remove pci_find_device usage from pci sysfs code.

> diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> --- a/drivers/pci/pci-sysfs.c	2005-03-04 12:41:33 -08:00
> +++ b/drivers/pci/pci-sysfs.c	2005-03-04 12:41:33 -08:00
> @@ -481,7 +481,7 @@
>  	struct pci_dev *pdev = NULL;
>
>  	sysfs_initialized = 1;
> -	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL)
> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL)
>  		pci_create_sysfs_dev_files(pdev);
>
>  	return 0;

Any reasons why you are not using "for_each_pci_dev(pdev)" here?

Eike

--nextPart1184857.6k3G3EXZuE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCPY6MXKSJPmm5/E4RAmXvAJ90lJQXw5QvxgLV02Fg6RMgPxnuDwCeLikE
qlyy4+O+oSZ4cV3fM6jI3u0=
=PGzp
-----END PGP SIGNATURE-----

--nextPart1184857.6k3G3EXZuE--
