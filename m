Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268746AbUH3Rvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268746AbUH3Rvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268718AbUH3RtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:49:03 -0400
Received: from pop.gmx.de ([213.165.64.20]:21705 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268697AbUH3RrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:47:20 -0400
X-Authenticated: #4512188
Message-ID: <41336824.1040206@gmx.de>
Date: Mon, 30 Aug 2004 19:47:16 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [patch] libata: add ioctls to support SMART
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com>
In-Reply-To: <200408301531.i7UFVBg29089@ra.tuxdriver.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

John W. Linville wrote:
| Support for HDIO_DRIVE_CMD and HDIO_DRIVE_TASK in libata.  Useful for
| supporting SMART w/ unmodified smartctl and smartd userland binaries.
|
| Not happy w/ loop after failed ata_qc_new_init(), but needed because
smartctl
| and smartd did not retry after failure.  Likely need an option to wait for
| available qc?  Also not sure all the error return codes are correct...

Hi,

I just tried to give it a go with libata from 2.6.9-rc1. I had to fix
one rejects but the patching seemed to go fine beside that. Nevertheless
after a boot with patched libata I get:

smartctl -a /dev/sda
smartctl version 5.30 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device: ATA      SAMSUNG SP1614N  Version: TM10
Serial number: 0735J1FW702444
Device type: disk
Local Time is: Mon Aug 30 19:44:23 2004 CEST
Device does not support SMART

Device does not support Error Counter logging

[GLTSD (Global Logging Target Save Disable) set. Enable Save with '-S on']
Device does not support Self Test logging


I am pretty sure my drive supports SMART. I hope that I understood your
post correctly that with this patch it should work.

Cheers,

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBM2gkxU2n/+9+t5gRAh1ZAJ0T1/zurwQZg7ddQx4X2aS5x8UMIgCg0hra
3D+Bhyp5MKpLVGdh7WIdPYA=
=Axdm
-----END PGP SIGNATURE-----
