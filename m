Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWDTOtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWDTOtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDTOtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:49:03 -0400
Received: from iona.labri.fr ([147.210.8.143]:54171 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1750933AbWDTOtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:49:01 -0400
Message-ID: <44479E8B.8010003@labri.fr>
Date: Thu, 20 Apr 2006 16:45:31 +0200
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, GarnierB-02@mail.europcar.com
Subject: Re: [libata] atapi_enabled problem
References: <44477D93.50501@labri.fr>
In-Reply-To: <44477D93.50501@labri.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additional comments:

Emmanuel Fleury wrote:
> 
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
> sr: Current [descriptor]: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51

Benoit Garnier did point to me this thread: http://kerneltrap.org/node/5836

The solution proposed can't be applied to me because I have a dual
system where my HD is IDE/ATAPI and my DVD reader is S-ATA.

Indeed, I tried out several possibilities and it appeared that the way
to generate such errors was to set the Intel PIIX/ICH SATA support as
built-in (y). When set as module (m), everything is fine.

Device Drivers --->
  SCSI device support --->
    SCSI low-level drivers --->
      Intel PIIX/ICH SATA support

I might have changed this when hard-coding atapi_enabled=1 in the source.

Does someone see the light now ? (I'm still a bit in the dark)

Regards
-- 
Emmanuel Fleury              | Office: 211
Associate Professor,         | Phone: +33 (0)5 40 00 35 24
LaBRI, Domaine Universitaire | Fax:   +33 (0)5 40 00 66 69
351, Cours de la Libération  | email: emmanuel.fleury@labri.fr
33405 Talence Cedex, France  | URL: http://www.labri.fr/~fleury
