Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030642AbWK3QFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030642AbWK3QFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 11:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967828AbWK3QFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 11:05:38 -0500
Received: from smtp-02.mandic.com.br ([200.225.81.133]:26598 "EHLO
	smtp-02.mandic.com.br") by vger.kernel.org with ESMTP
	id S967836AbWK3QFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 11:05:38 -0500
Message-ID: <456F0149.60303@mandic.com.br>
Date: Thu, 30 Nov 2006 14:05:29 -0200
From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [git patches] libata fixes
References: <20061130104818.GA29216@havoc.gtf.org>
In-Reply-To: <20061130104818.GA29216@havoc.gtf.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=D420515A;
	url=http://pgp.mit.edu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik escreveu:
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -225,6 +225,7 @@ static struct scsi_host_template sil680_
>  	.proc_name		= DRV_NAME,
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
> +	.slave_destroy		= ata_scsi_slave_destroy,
>  	.bios_param		= ata_std_bios_param,
>  };

I save this text above, but when I run "patch -p1", I receive this error
message:

"missing header for unified diff at line 3 of patch
patching file drivers/ata/pata_sil680.c"

- --
Renato S. Yamane
Fingerprint: 68AE A381 938A F4B9 8A23  D11A E351 5030 D420 515A
PGP Server: http://pgp.mit.edu/ --> KeyID: 0xD420515A
<http://www.renatoyamane.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFbwFJ41FQMNQgUVoRAgYNAJ489ilJfzO/J0U1TK7u1AA1vqVzgwCgjaC9
E/PuMo0LHV/6Mpi5Q0nd0c8=
=s3AJ
-----END PGP SIGNATURE-----
