Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVGGIjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVGGIjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVGGIjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:39:24 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:22068 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261250AbVGGIg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:36:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uBKImZ10HQn0rJpBTQ3Jj81jwtiFkZqWec6GeAHuVujD67Rjl46IVxk33QaEvMgrb0+CwUNIcwp+52CMVB6NGoi9/XFMWj4wFekCwK/+adgNX+jviyNG7s7/UBrMgZ4CkCForvid2fafHoEO8sxtOFLn/07ZMcMp4MCVO4cePgw=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: SATA: Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3052
Date: Thu, 7 Jul 2005 12:43:38 +0400
User-Agent: KMail/1.8.1
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <1120723473.18056.29.camel@localhost>
In-Reply-To: <1120723473.18056.29.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071243.39080.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 July 2005 12:04, Soeren Sonnenburg wrote:
> with hddtemp regularly polling for the temperature state together with
> libsata from kernel 2.6.12 on a promise tx2. The disk is set to go to
> sleep mode (hdparm -S 35 /dev/sda). And after a couple of hours the
> machine oopsed (the disk was sleeping/not mounted at that time - with
> high probability) :
> 
> ata2: command timeout
> ata2: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3052
> ata2: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata2: status=0xb0 { Busy }
> Unable to handle kernel NULL pointer dereference at virtual address 00000000

> EIP:    0060:[<c0118eac>]    Tainted: P      VLI

> I am now trying w/o hddtemp, lets see how long it survives...

With untainted kernel, please. To be sure it's our problem.
