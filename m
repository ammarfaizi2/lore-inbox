Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130207AbRAXO7Q>; Wed, 24 Jan 2001 09:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbRAXO7G>; Wed, 24 Jan 2001 09:59:06 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:39572 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S129631AbRAXO6x>;
	Wed, 24 Jan 2001 09:58:53 -0500
Date: Wed, 24 Jan 2001 15:57:13 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Tim Sullivan <tsulliva@iex.net>
cc: Matt_Domsch@Dell.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No SCSI Ultra 160 with Adaptec Controller
In-Reply-To: <3A6E7991.6377220F@iex.net>
Message-ID: <Pine.LNX.4.21.0101241552420.30193-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Tim Sullivan wrote:

> Matt_Domsch@Dell.com wrote:
> > 
> > Yes, that code is still necessary.  There's a new aic7xxx driver by Justin
> > Gibbs at Adaptec which is now being beta tested which corrects this issue.
> 
> Justin's 6.0.9beta(latest release) hasn't corrected the problem yet.
> 
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.0.9 BETA
>         <Adaptec 29160 Ultra160 SCSI adapter>
>         aic7892: Wide Channel A, SCSI Id=7, 32/255 SCBs
> 
>   Vendor: QUANTUM   Model: ATLAS10K2-TY367L  Rev: DDD6
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> (scsi0:A:0): async, 8bit
> scsi0:0:0:0: Tagged Queuing enabled.  Depth 8
> Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
> (scsi0:A:0): async, 16bit
> (scsi0:A:0): synchronous at 80.0MHz DT, offset 0x7f, 16bit
> SCSI device sda: 71721820 512-byte hdwr sectors (36722 MB)

I just had to jump into this thread and say this:

The way I see it:
	80MHz * 16bit = 160MB/s

This is output from kernel 2.4.1-pre10 with Justin's 6.0.9beta driver:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.0.9 BETA
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Wide Channel A, SCSI Id=7, 32/255 SCBs
 
  Vendor: IBM       Model: DDYS-T18350N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:6): async, 8bit
scsi0:0:6:0: Tagged Queuing enabled.  Depth 32
Detected scsi disk sda at scsi0, channel 0, id 6, lun 0
async, 16bit
synchronous at 80.0MHz DT, offset 0x3f, 16bit
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
