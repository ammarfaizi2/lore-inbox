Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285406AbRLNQYB>; Fri, 14 Dec 2001 11:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285404AbRLNQXw>; Fri, 14 Dec 2001 11:23:52 -0500
Received: from rj.SGI.COM ([204.94.215.100]:49352 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S285406AbRLNQXc>;
	Fri, 14 Dec 2001 11:23:32 -0500
Message-ID: <3C1A27FA.7000807@sgi.com>
Date: Fri, 14 Dec 2001 10:25:30 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "David S. Miller" <davem@redhat.com>, gibbs@scsiguy.com,
        LB33JM16@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
In-Reply-To: <200112132048.fBDKmog10485@aslan.scsiguy.com> <1008277112.22093.7.camel@jen.americas.sgi.com> <1008278244.22208.12.camel@jen.americas.sgi.com> <20011213.132734.38711065.davem@redhat.com> <20011214151642.GE30529@suse.de> <20011214161506.GB1180@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Fri, Dec 14 2001, Jens Axboe wrote:
>
>>*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre11/bio-pre11-5.bz2
>>
>
>--- linux/drivers/scsi/sym53c8xx.c~	Fri Dec 14 11:10:38 2001
>+++ linux/drivers/scsi/sym53c8xx.c	Fri Dec 14 11:10:51 2001
>@@ -12174,7 +12174,7 @@
> 
> 		use_sg = map_scsi_sg_data(np, cmd);
> 		if (use_sg > MAX_SCATTER) {
>-			unmap_scsi_sg_data(np, cmd);
>+			unmap_scsi_data(np, cmd);
> 			return -1;
> 		}
> 		data = &cp->phys.data[MAX_SCATTER - use_sg];
>
There is one of these in ncr53c8xx.c as well, line 8135

Steve



