Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWEPAIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWEPAIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWEPAIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:08:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:21666 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750852AbWEPAIW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:08:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gkRyJ72OYQRMvfZ8OnHj2vZzPPLPNsy1Y5qlYuR02bDQwM9bnJWaP9/8VOJW3Cm+EkoZm0AIix4fu0zclefkwt9B6LJRlnBuBMZl130FurauSb0++jgY2PbkQUwL1/uVfcayft1iRAF5xyCMaqVP79ZIAwKg8OxT4McT1vAF7VU=
Message-ID: <3aa654a40605151708q2dc053c8h4778569042e3f7a3@mail.gmail.com>
Date: Mon, 15 May 2006 17:08:20 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
In-Reply-To: <446914C7.1030702@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060515170006.GA29555@havoc.gtf.org>
	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
	 <446914C7.1030702@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
> Avuton Olrich wrote:
> > On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
> >> * sata_sil and ata_piix also need healthy re-testing of all basic
> >> functionality.
> >
> > I'm testing it right now, but with 2.6.17-rc4-git2 I was getting:
>
> Testing what?  sata_sil?  Please provide full dmesg, there's a lot of
> missing information.

sata_sil, sorry, I thought I provided a good subset of the timeout message:

May 15 15:41:27 shapeshifter ata2: command 0x25 timeout, stat 0x58 host_stat 0x1
May 15 15:41:27 shapeshifter ata2: translated ATA stat/err 0x58/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
May 15 15:41:27 shapeshifter ata2: status=0x58 { DriveReady
SeekComplete DataRequest }
May 15 15:41:27 shapeshifter sd 1:0:0:0: SCSI error: return code = 0x8000002
May 15 15:41:27 shapeshifter sda: Current: sense key=0xb
May 15 15:41:27 shapeshifter ASC=0x47 ASCQ=0x0
May 15 15:41:27 shapeshifter end_request: I/O error, dev sda, sector 974708551
May 15 15:41:57 shapeshifter ata2: command 0x25 timeout, stat 0x58 host_stat 0x1
May 15 15:41:57 shapeshifter ata2: translated ATA stat/err 0x58/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
May 15 15:41:57 shapeshifter ata2: status=0x58 { DriveReady
SeekComplete DataRequest }
May 15 15:41:57 shapeshifter sd 1:0:0:0: SCSI error: return code = 0x8000002
May 15 15:41:57 shapeshifter sda: Current: sense key=0xb
May 15 15:41:57 shapeshifter ASC=0x47 ASCQ=0x0
May 15 15:41:57 shapeshifter end_request: I/O error, dev sda, sector 974708559
May 15 15:42:27 shapeshifter ata2: command 0x25 timeout, stat 0x58 host_stat 0x1
May 15 15:42:27 shapeshifter ata2: translated ATA stat/err 0x58/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
May 15 15:42:27 shapeshifter ata2: status=0x58 { DriveReady
SeekComplete DataRequest }
May 15 15:42:27 shapeshifter sd 1:0:0:0: SCSI error: return code = 0x8000002
May 15 15:42:27 shapeshifter sda: Current: sense key=0xb
May 15 15:42:27 shapeshifter ASC=0x47 ASCQ=0x0
May 15 15:42:27 shapeshifter end_request: I/O error, dev sda, sector 974708567
May 15 15:42:57 shapeshifter ata2: command 0x25 timeout, stat 0x58 host_stat 0x1
May 15 15:42:57 shapeshifter ata2: translated ATA stat/err 0x58/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
May 15 15:42:57 shapeshifter ata2: status=0x58 { DriveReady
SeekComplete DataRequest }
May 15 15:42:57 shapeshifter sd 1:0:0:0: SCSI error: return code = 0x8000002
May 15 15:42:57 shapeshifter sda: Current: sense key=0xb
May 15 15:42:57 shapeshifter ASC=0x47 ASCQ=0x0
May 15 15:42:57 shapeshifter end_request: I/O error, dev sda, sector 974708575
May 15 15:43:27 shapeshifter ata2: command 0x25 timeout, stat 0x58 host_stat 0x1
May 15 15:43:27 shapeshifter ata2: translated ATA stat/err 0x58/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
May 15 15:43:27 shapeshifter ata2: status=0x58 { DriveReady
SeekComplete DataRequest }
May 15 15:43:27 shapeshifter sd 1:0:0:0: SCSI error: return code = 0x8000002
May 15 15:43:27 shapeshifter sda: Current: sense key=0xb
May 15 15:43:27 shapeshifter ASC=0x47 ASCQ=0x0
May 15 15:43:27 shapeshifter end_request: I/O error, dev sda, sector 974708583
May 15 15:43:57 shapeshifter ata2: command 0x25 timeout, stat 0x58 host_stat 0x1
May 15 15:43:57 shapeshifter ata2: translated ATA stat/err 0x58/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
May 15 15:43:57 shapeshifter ata2: status=0x58 { DriveReady
SeekComplete DataRequest }
May 15 15:43:57 shapeshifter sd 1:0:0:0: SCSI error: return code = 0x8000002
May 15 15:43:57 shapeshifter sda: Current: sense key=0xb
May 15 15:43:57 shapeshifter ASC=0x47 ASCQ=0x0
May 15 15:43:57 shapeshifter end_request: I/O error, dev sda, sector 974708591
May 15 15:44:02 shapeshifter SysRq : Emergency Sync
May 15 15:44:02 shapeshifter Emergency Sync complete
May 15 15:44:27 shapeshifter ata2: command 0x25 timeout, stat 0x58 host_stat 0x1
May 15 15:44:27 shapeshifter ata2: translated ATA stat/err 0x58/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
May 15 15:44:27 shapeshifter ata2: status=0x58 { DriveReady
SeekComplete DataRequest }
May 15 15:44:27 shapeshifter sd 1:0:0:0: SCSI error: return code = 0x8000002
May 15 15:44:27 shapeshifter sda: Current: sense key=0xb
May 15 15:44:27 shapeshifter ASC=0x47 ASCQ=0x0
May 15 15:44:27 shapeshifter end_request: I/O error, dev sda, sector 974708599
May 15 15:44:35 shapeshifter NETDEV WATCHDOG: eth2: transmit timed out

> > After large ssh transfers. I moved to 2.6.17-rc4-git2 because
> > 2.6.16.16 was doing the same. This is a new 500gb sata2 drive on
> > sata_sil so I guess this could be hardware, but I wanted to make sure
> > before I go returning this thing. After this obviously I have to sysrq
> > sync, ro and reboot. This also causes(?) a NETDEV WATCHDOG: eth2:
> > transmit timed out, sometimes this ata timeout doesn't yet occur and I
> > just get the netdev watchdog. This has not yet happened with the new
> > patch, though I'm only 1 hr into testing with it.
>
> Yes, its entirely possible that the new patch will address this.  Please
> do keep us posted.
>
> Thanks,
>
>         Jeff

OK, upon further testing I believe the patch helps out tremendously, I
don't get the timeout message (yet), though I still get a netdev
watchdog. I've gotten this with two different ethernet ports/drivers
so I believe this not to be due to the ethernet driver.

Sample dmesg output:
NETDEV WATCHDOG: eth2: transmit timed out

The time that it actually takes to happen is variable, though it
hasn't happened to me in under 20 minutes yet.

-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
