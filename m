Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269583AbRHAAtF>; Tue, 31 Jul 2001 20:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269581AbRHAAsn>; Tue, 31 Jul 2001 20:48:43 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:39940 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269574AbRHAAsf>; Tue, 31 Jul 2001 20:48:35 -0400
Date: Tue, 31 Jul 2001 18:48:44 -0600
Message-Id: <200108010048.f710miA05150@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Mike Anderson <mike.anderson@us.ibm.com>
Cc: Jeremy Higdon <jeremy@classic.engr.sgi.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Eric Youngdale <eric@andante.org>
Subject: Re: [RFT] Support for ~2144 SCSI discs
In-Reply-To: <20010731125926.B10914@us.ibm.com>
In-Reply-To: <200107310030.f6V0UeJ13558@mobilix.ras.ucalgary.ca>
	<rgooch@ras.ucalgary.ca>
	<10107310041.ZM233282@classic.engr.sgi.com>
	<200107311225.f6VCPj003249@mobilix.ras.ucalgary.ca>
	<20010731125926.B10914@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Mike Anderson writes:
> In previous experiments trying to connect up to 512 devices we
> switched to vmalloc because the static nature of sd.c's allocation
> exceeds 128k which I assumed was the max for kmalloc YMMV.

Yes, I figure on switching to vmalloc() and putting in an
in_interrupt() test in sd_init() to make sure the vmalloc() is safe.

Eric: do you happen to know why there are these GFP_ATOMIC flags?
To my knowledge, nothing calls sd_init() outside of process context.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
