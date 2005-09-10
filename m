Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVIJPGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVIJPGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 11:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbVIJPGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 11:06:21 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:47282 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751014AbVIJPGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 11:06:20 -0400
Subject: Re: aic79xx oops
From: James Bottomley <James.Bottomley@SteelEye.com>
To: bernd-schubert@gmx.de
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200509091325.45620.bernd.schubert@pci.uni-heidelberg.de>
References: <200509091325.45620.bernd.schubert@pci.uni-heidelberg.de>
Content-Type: text/plain
Date: Sat, 10 Sep 2005 10:06:05 -0500
Message-Id: <1126364765.4813.16.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 13:25 +0200, Bernd Schubert wrote:
>   Vendor: transtec  Model: T5008             Rev: 0001
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> scsi4:A:0:0: Tagged Queuing enabled.  Depth 32
> SCSI device sdc: 4101521408 512-byte hdwr sectors (2099979 MB)
> SCSI device sdc: drive cache: write back
> SCSI device sdc: 4101521408 512-byte hdwr sectors (2099979 MB)
> SCSI device sdc: drive cache: write back
>  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 sdc8 >
> Attached scsi disk sdc at scsi4, channel 0, id 0, lun 0
> Attached scsi generic sg2 at scsi4, channel 0, id 0, lun 0,  type 0
> scsi: host 4 channel 0 id 0 lun 0x00000200080c0400 has a LUN larger than 
> currently supported.
> scsi: host 4 channel 0 id 0 lun1002486961 has a LUN larger than allowed by the 
> host adapter
> scsi: host 4 channel 0 id 0 lun 0x01000000407a27c0 has a LUN larger than 
> currently supported.
> scsi: host 4 channel 0 id 0 lun 0x007a27c0d05d27c0 has a LUN larger than 
> currently supported.
> scsi: host 4 channel 0 id 0 lun 0x305e27c0907b27c0 has a LUN larger than 
> currently supported.
> scsi: host 4 channel 0 id 0 lun 0xf08227c0b08d27c0 has a LUN larger than 
> currently supported.
> scsi: host 4 channel 0 id 0 lun 0x307827c0008527c0 has a LUN larger than 
> currently supported.
> scsi: host 4 channel 0 id 0 lun 0x00000000b06727c0 has a LUN larger than 
> currently supported.
> scsi: host 4 channel 0 id 0 lun 0x306727c0706727c0 has a LUN larger than 
> currently supported.

This looks symptomatic of a report luns failure

> EIP is at ahd_send_async+0xde/0x2a0 [aic79xx]

This I'm not sure about.  There are some fixes that may correct this in
the current kernel tree head (i.e. beyond 2.6.13), if you could give
that a go.

James



