Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVIOMXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVIOMXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVIOMXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:23:33 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:31109 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751181AbVIOMXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:23:32 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: PCI driver
Date: Thu, 15 Sep 2005 14:24:18 +0200
User-Agent: KMail/1.8.2
Cc: Manu Abraham <manu@linuxtv.org>, Ralph Metzler <rjkm@metzlerbros.de>,
       Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
References: <4327EE94.2040405@kromtek.com> <43295E41.8010808@linuxtv.org> <43296445.8040805@gmail.com>
In-Reply-To: <43296445.8040805@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2775961.oCJOhcTA2V";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509151424.27077@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2775961.oCJOhcTA2V
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Antonino A. Daplas wrote:
>Manu Abraham wrote:
>> Ralph Metzler wrote:
>>
>>
>>                SA_INTERRUPT, DRIVER_NAME, mantis) < 0) {
>>        dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ reg failed");
>>        goto err2;
>>    }
>>    dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
>>    dprintk(verbose, MANTIS_DEBUG, 1, "We finally enabled the device");
>>    pci_set_master(pdev);
>>    pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
>>    pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
>>    mantis->latency =3D latency;
>>    mantis->revision =3D revision;
>>    if (!latency) {
>>        pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
>>    }
>>    pci_set_drvdata(pdev, mantis);      dprintk(verbose, MANTIS_ERROR, 0,
>> "Mantis Rev %d, ", mantis->revision);
>>    dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\n \
>>        memory: 0x%04x, mmio: %p\n", pdev->irq, mantis->latency,    \
>>        mantis->mantis_addr, mantis->mantis_mmio);
>
>Success!  So don't enter the failure path, return 0 here.
>
>>   err2:
>>    if (mantis->mantis_mmio)
>>        iounmap(mantis->mantis_mmio);
>> err1:
>>    release_mem_region(pci_resource_start(pdev, 0),
>>                pci_resource_len(pdev, 0));
>> err0:
>>    kfree(mantis);
>> err:
>>    return 0;
>
>This is your failure path, return nonzero here, preferable describing the
>error condition.

Hey Tony, you get a penalty for not using PGP. If you had used it my mail=20
would not have been sent 7 seconds after yours :))

Eike

--nextPart2775961.oCJOhcTA2V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDKWf7XKSJPmm5/E4RAlVAAJ9TZOiK6rfXMIhJHWHPSGfvar6O9wCcDvDM
tlD9mEwdjem7a2XWLUawJXE=
=4e+0
-----END PGP SIGNATURE-----

--nextPart2775961.oCJOhcTA2V--
