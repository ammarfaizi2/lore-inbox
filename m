Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTD1Swr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbTD1Swr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:52:47 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:57550 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S261241AbTD1Swq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:52:46 -0400
Date: Mon, 28 Apr 2003 13:04:46 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Oliver Sommer <oliver@kernzeit.com>, linux-kernel@vger.kernel.org
Subject: Re: [bugreport] aic7xxx, DV failed to configure device
Message-ID: <765800000.1051556686@aslan.btc.adaptec.com>
In-Reply-To: <200304281535.05891.oliver@kernzeit.com>
References: <200304281535.05891.oliver@kernzeit.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the kernel logging messages ask me to file this "bug report".
> I hope this is the right place to do so.
> 
> 
> --snip--
> 
> SCSI subsystem driver Revision: 1.00
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
>         <Adaptec 2940 Ultra2 SCSI adapter (OEM)>
>         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
> scsi0:A:0:0: DV failed to configure device.  Please file a bug report against 
> this driver.
> (scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
>   Vendor: IBM       Model: DDYS-T18350N      Rev: S80D
>   Type:   Direct-Access                      ANSI SCSI revision: 03
>   Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
>   Type:   Direct-Access                      ANSI SCSI revision: 03

You need newer firmware.  This firmware rev. don't implement the
echo buffer that is mandatory for U160 and is used to perform
Domain Validation.  There are also lots of other bugs in this
firmware rev.  Call IBM (or perhaps it is now Hitachi) for an
update and the error message will go away.

--
Justin

