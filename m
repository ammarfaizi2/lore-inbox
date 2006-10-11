Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161437AbWJKVTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161437AbWJKVTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161376AbWJKVTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:19:41 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:690 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161446AbWJKVTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:19:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ccR2doUZy+/9j/acQP7vUSZvS3IeW4Gwx+LN+xI194wZaPwXXQTmZqtxu5W197z9qtelYEdwdysB9iaIlIKs++GwzXkpgi40VsFEBnYCiSznPsOZWs9Slu3UBcEDOnoNZ6Gn94cMqoJAn66biknymPEv0VSCOxEtc+R9HeTHBqg=
Message-ID: <fc94aae90610111419g647e554ay42105db77d4f712c@mail.gmail.com>
Date: Wed, 11 Oct 2006 22:19:16 +0100
From: "Michael Lothian" <mike@fireburn.co.uk>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc1-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010000928.9d2d519a.akpm@osdl.org>
X-Google-Sender-Auth: 831ac5ed996c00e3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
>
>
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
>
>
> git-libata-all.patch
>
>
>

Hi

I think I've found a regression in the pata-via module. My cdrom drive isn't
detected I have compiled in and also tried as modules pata-via and the SCSI
CDROM device driver

I think the problem may be due to my cdrom not having a jumper setting
either master or slave (or even cable select for that matter) as I lost the
wee jumper.

Even if this is the case I'd still call this a regression as the old code
finds it no problem

My dmesg states:

pata_via 0000:00:0f.1: version 0.1.14
ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xA400 irq 14
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xA408 irq 15
scsi2 : pata_via
ata3.00: ATAPI, max UDMA/33
EXT3-fs: mounted filesystem with ordered data mode.
ata3.00: qc timeout (cmd 0xa1)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata3.00: revalidation failed (errno=-5)
ata3.00: limiting speed to UDMA/25
ata3: failed to recover some devices, retrying in 5 secs
ata3.00: qc timeout (cmd 0xa1)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata3.00: revalidation failed (errno=-5)
ata3: failed to recover some devices, retrying in 5 secs
ata3.00: qc timeout (cmd 0xa1)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata3.00: revalidation failed (errno=-5)
ata3.00: disabled
scsi3 : pata_via
ATA: abnormal status 0x8 on port 0x177


Does anyone have any ideas on why this is the case?

Cheers for any help you can offer

Mike

PS Apologies for the 3rd time your receiving this andrew
