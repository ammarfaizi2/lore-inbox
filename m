Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424885AbWKQBa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424885AbWKQBa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424886AbWKQBa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:30:28 -0500
Received: from nz-out-0102.google.com ([64.233.162.206]:18194 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1424885AbWKQBa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:30:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=upnTLy+UuAjm2Ho9jA1YwfsjH4BoJC5kcnNl+OE4muLcOuzuC/0sbsqsQIsBP8iQRMiAd+dpu6lvTifGwx2jKQmcESrjnUfocAFXaaacEY3G4ON/ITnN/7Iorqg2UyNHjNaeC/8nB4R11g3dSYrStKfT0TxuSS+JiihJ3S7KNf8=
Message-ID: <df47b87a0611161730p70e1dd41iad7d27a0bf9283ff@mail.gmail.com>
Date: Thu, 16 Nov 2006 20:30:27 -0500
From: "Ioan Ionita" <opslynx@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19-rc5 libata PATA ATAPI CDROM SiS 5513 NOT WORKING
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, htejun@gmail.com,
       alan@redhat.com
In-Reply-To: <20061116235048.3cd91beb@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <df47b87a0611161522o3ad007f5i8804c876c50e591c@mail.gmail.com>
	 <20061116235048.3cd91beb@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 16 Nov 2006 18:22:47 -0500
> "Ioan Ionita" <opslynx@gmail.com> wrote:
>
> > I gave libata a shot. Hardisk works fine. However the CDROM doesn't.
> > It would seem that the CDROM is detected, but the device node is not
> > created.
> >
> > I do have libata.atapi_enabled=1 as a kernel parameter. This is a Vaio
> > laptop, with SiS 5513, PATA only, no SATA ports.
> >
> > Did I miss anything?
>
> From the trace looks like the SCSI CD-ROM Driver is not compiled in
> and/or loaded.

Yes. I'm sorry I missed that. I enabled it, but it still doesn't work.
Some timeouts are occurring when I try to mount the CD-ROM. The CD-ROM
works fine with the old IDE framework. Here's the dmesg errors that
occur with libata and scsi cdrom support:

ata2.00: qc timeout (cmd 0xa0)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x20)
ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: qc timeout (cmd 0xa0)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x20)
ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: qc timeout (cmd 0xa0)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x20)
ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: qc timeout (cmd 0xa0)
ata2.00: limiting speed to UDMA/25
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x20)
ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
