Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWFTFlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWFTFlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWFTFlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:41:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:62550 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965048AbWFTFlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:41:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iMUvl44W7P9l7NO7RKv5Axci2ezSQaTl9MvJnbiyCz3AYDRT1ctZ0x/jmZlHVRxWwHHxlchzN1tBp8W1Bc/z1m743y2aFSR3VKZORFltt1lFGiDifY+b0xdyUQlvyhUJ+GIYzvejn0+V0SO9r/j6OVHh0dnMcfedsOCJjrmPdRc=
Message-ID: <b637ec0b0606192241w33eb7061kd32860b5b23db663@mail.gmail.com>
Date: Tue, 20 Jun 2006 07:41:33 +0200
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA driver patch for 2.6.17
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1150751279.2871.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150740947.2871.42.camel@localhost.localdomain>
	 <e76uv1$g1s$1@sea.gmane.org>
	 <1150751279.2871.46.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

> Sorry about that. I messed up a patch segment in the merge
>
> --- drivers/scsi/ata_piix.c~    2006-06-19 21:38:43.746144712 +0100
> +++ drivers/scsi/ata_piix.c     2006-06-19 21:38:43.747144560 +0100
> @@ -360,6 +360,8 @@
>         .qc_prep                = ata_qc_prep,
>         .qc_issue               = ata_qc_issue_prot,
>
> +       .data_xfer              = ata_pio_data_xfer,
> +
>         .eng_timeout            = ata_eng_timeout,
>
>         .irq_handler            = ata_interrupt,
>
> -

Is this patch supposed to be applied also on systems with only PATA
drives? My laptop does not have SATA and does not show this bug.

thanks,
Fabio
