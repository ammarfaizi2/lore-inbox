Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVJRHP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVJRHP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVJRHP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:15:28 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:37012 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751395AbVJRHP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:15:28 -0400
Message-ID: <4354A09C.8010202@dresco.co.uk>
Date: Tue, 18 Oct 2005 08:13:32 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Gyes <floam@sh.nu>
CC: linux-kernel@vger.kernel.org
Subject: Re: ATA warnings in dmesg
References: <1129609999.10504.1.camel@localhost>
In-Reply-To: <1129609999.10504.1.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Heisenberg-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Gyes wrote:

>For the last few -mm releases (maybe longer, maybe it's in non-mm also)
>my dmesg is full of this:
>
>ata1: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
>ata1: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
>ata1: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
>ata1: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
>
>I've got a Western Digital Raptor 74GB, using sata-via on a K8T800 Pro.
>Should I be scared?
>
>Aaron Gyes
>  
>

I don't think you need to worry. Those messages are produced from the 
libata passthough code, whenever sense data has been requested...

0xb0 looks like a SMART command, so I would guess (haven't looked at 
-mm) that the ata ioctl handlers have been updated to request it.

Regards,
Jon.


______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
