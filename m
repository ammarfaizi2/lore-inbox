Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVFGN01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVFGN01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVFGN01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:26:27 -0400
Received: from gw.anda.ru ([83.146.86.58]:13070 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S261860AbVFGN0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:26:23 -0400
Date: Tue, 7 Jun 2005 19:16:46 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PROBLEM] aic7xxx: DV failed to configure device
Message-ID: <20050607191646.A30496@ward.six>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <20050606141638.A28532@ward.six> <1118045986.5652.21.camel@laptopd505.fenrus.org> <20050606150321.A817@ward.six> <1118068477.5045.27.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118068477.5045.27.camel@mulgrave>; from James.Bottomley@SteelEye.com on Mon, Jun 06, 2005 at 09:34:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 09:34:37AM -0500, James Bottomley wrote:
> On Mon, 2005-06-06 at 15:03 +0600, Denis Zaitsev wrote:
> > Yes, I'm sorry.  2.6.10.
> 
> That particular code was completely changed for 2.6.12-rc5; could you
> see what that kernel makes of this, please?

Ok, 2.6.12-rc5:


scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DDYS-T09170N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:0): 6.600MB/s transfers (16bit)
 target0:0:0: Domain Validation skipping write tests
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
 target0:0:0: Ending Domain Validation
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sda: drive cache: write back
 sda: unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0


It seems that things are in order, do I understand right?  So, why and
how the low-level format affects the old driver's behaviour?

Thanks in advance.
