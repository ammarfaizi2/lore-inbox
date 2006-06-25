Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWFYPXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWFYPXH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWFYPXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 11:23:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:30374 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932427AbWFYPXF (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 11:23:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tVT3ONXJcRVKQ4jRfL6K7DA48ex27JCg43oKaA/36g1NIWVTB5NES8tICYYQstAXdx8he/i0z6TQiQzOHISxeBfnJtHAkZ6j7r+eCy2uIVibDKqgAkWwtAnSrok0pUALDwxstjVLiGaaUSAPXj4fw25wJQAqdbbFokA/+zjzfJM=
Message-ID: <3b0ffc1f0606250823h49ec5c9cy180d4941d6c9c8b@mail.gmail.com>
Date: Sun, 25 Jun 2006 11:23:02 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA driver patch for 2.6.17
Cc: Linux-Kernel@vger.kernel.org
In-Reply-To: <1150740947.2871.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150740947.2871.42.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> http://zeniv.linux.org.uk/~alan/IDE
>
> This is basically a resync versus 2.6.17, the head of the PATA tree is
> now built against Jeffs tree with revised error handling and the like.
>
> Alan

Hrm, I finally tried a different CF card (Viking 256MB) from the one I
usually use in my camera, and it failed to work:

pccard: PCMCIA card inserted into slot 1
pcmcia: registering new device pcmcia1.0
ata6: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 3
ata6: dev 0 cfg 49:0200 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata6: dev 0 ATA-0, max PIO0, 500736 sectors: LBA
ata6: failed to set xfermode (err_mask=0x1)
scsi6 : pata_pcmcia

Here's me sticking in my Sandisk Ultra II 1GB CF card and it working
immediately after:

pccard: card ejected from slot 1
pccard: PCMCIA card inserted into slot 1
pcmcia: registering new device pcmcia1.0
ata7: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 3
ata7: dev 0 cfg 49:0200 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata7: dev 0 ATA-10, max PIO4, 2001888 sectors: LBA
ata7: dev 0 configured for PIO0
scsi7 : pata_pcmcia
  Vendor: ATA       Model: SanDisk SDCFH-10  Rev: HDX
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 2001888 512-byte hdwr sectors (1025 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write through
SCSI device sdb: 2001888 512-byte hdwr sectors (1025 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write through
 sdb: sdb1
sd 7:0:0:0: Attached scsi removable disk sdb
sd 7:0:0:0: Attached scsi generic sg2 type 0

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
