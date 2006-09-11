Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWIKTeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWIKTeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWIKTeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:34:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:65212 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964944AbWIKTeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:34:08 -0400
Message-ID: <4505BA2B.1020105@garzik.org>
Date: Mon, 11 Sep 2006 15:34:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Vendor field with USB, [SP]ATA etc-attached disks
References: <4505A612.8070603@tls.msk.ru>
In-Reply-To: <4505A612.8070603@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> With current SATA, PATA and at least some USB disks,
> Linux reports Vendor: $subsystem, instead of the actual
> vendor of the drive, like this:
> 
> scsi1 : ata_piix
>   Vendor: ATA       Model: ST3808110AS       Rev: n/a
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> 
> This should be Vendor: Seagate, not ATA (Note also the lack
> of "Revision" field).  The same for PATA disk:
> 
> scsi0 : pata_via
>   Vendor: ATA       Model: ST3120026A        Rev: 3.76
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> 
> The same is shown in /sys/block/$DEV/device/vendor.
> 
> Can it be changed to show real vendor, instead of the subsystem name?

No.  Two reasons:

* ATA doesn't export the vendor separate from the model, and in some 
cases (Seagate) it isn't present at all, anywhere.
* "ATA" vendor string is the standardized value to put in that field, 
according to the SCSI T10 specifications.

	Jeff



