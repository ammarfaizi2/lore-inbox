Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270279AbRHMQXn>; Mon, 13 Aug 2001 12:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270273AbRHMQXe>; Mon, 13 Aug 2001 12:23:34 -0400
Received: from guestpc.physics.umanitoba.ca ([130.179.72.122]:2564 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268870AbRHMQXW>; Mon, 13 Aug 2001 12:23:22 -0400
Date: Mon, 13 Aug 2001 11:23:30 -0500
Message-Id: <200108131623.f7DGNUh00874@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs, scsi_debug
In-Reply-To: <3B73D9F0.8BE1B0D1@torque.net>
In-Reply-To: <200108020642.f726g0L15715@mobilix.ras.ucalgary.ca>
	<3B735FCF.E197DD5B@torque.net>
	<200108100431.f7A4VkG01068@mobilix.ras.ucalgary.ca>
	<3B73D9F0.8BE1B0D1@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert writes:
> Richard Gooch wrote:
> > 
> > Douglas Gilbert writes:
> > > Note the large major device number that devfs is pulling
> > > from the unused pool. Devfs makes some noise when
> > > 'rmmod scsi_debug' is executed but otherwise things looked
> > > ok.
> 
> After several seconds of silence, lots of these appeared:
>  devfs_dealloc_unique_number(): number 128 was already free
>  devfs_dealloc_unique_number(): number 128 was already free

OK, I found the problem. Stupid not-updating-a-counter error. I then
tried your modified scsi_debug driver and it works fine. I'll put out
a new patch shortly.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
