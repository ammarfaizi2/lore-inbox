Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265877AbUFDRRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUFDRRn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUFDRRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:17:43 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:28351 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265877AbUFDRRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:17:41 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Asus SK8N (x86_64) motherboard ata1 DMA timeout (Promise SATA)
Date: Fri, 4 Jun 2004 19:26:06 +0200
User-Agent: KMail/1.5
Cc: len.brown@intel.com
References: <200406041045.36908.andrew@walrond.org>
In-Reply-To: <200406041045.36908.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406041926.06568.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 of June 2004 11:45, Andrew Walrond wrote:
> Using linux-2.6.7-rc2 (32bit), two SATA drives on Promise TX2plus. The bios
> has been upgraded to latest version 1007.
>
> Without any kernel parameters, the i/o locks after a short time copying
> files. Copied by hand from dmesg after i/o freeze:
>
> ata1 DMA timeout
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x2a 00 04 ae a2 f2 00 00 08
> 00 Current sda: sense = 70 3
> ASC= c ASCQ= 2
> Raw sense data: 0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00
> 0x0c 0x02
> end_request: I/O error, dev sda, sector 78553842

I saw something like this on a SiI 3114 controller, but then I thought it was 
because of a failing drive, since the second one that was attached to another 
SATA channel worked just fine at the same time.  I didn't try it with the 
acpi=off setting (the system was a dual Opteron w/ AMD chipset, and the 
kernel was a 2.6.7-rc1, AFAIR).

rjw

