Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSKTTGy>; Wed, 20 Nov 2002 14:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSKTTGy>; Wed, 20 Nov 2002 14:06:54 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:2323 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S262492AbSKTTGi>; Wed, 20 Nov 2002 14:06:38 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB196D@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Steven Timm'" <timm@fnal.gov>, Manish Lachwani <manish@Zambeel.com>
Cc: "'Barry K. Nathan'" <barryn@pobox.com>, linux-kernel@vger.kernel.org
Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
Date: Wed, 20 Nov 2002 11:13:27 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, acoustic management can be reduced by writing a unix based utility that
will send the appropriate commands to the drive to reducd the acoustic
levels. The acoustic levels can be varied from 0x80 (quiet mode) to 0xfe
(performance mode). By moving the acoustic levels lower, we can reduce the
heat/power consumption ...

Thanks
Manish

-----Original Message-----
From: Steven Timm [mailto:timm@fnal.gov]
Sent: Wednesday, November 20, 2002 6:29 AM
To: Manish Lachwani
Cc: 'Barry K. Nathan'; linux-kernel@vger.kernel.org
Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }


Any idea how to reduce the acoustic mode from performance to quiet?
Nothing in the seagate tools as far as I can tell.

Steve


------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

On Tue, 19 Nov 2002, Manish Lachwani wrote:

> Basically, I could also control the temperature of the seagate drives by
> operating them in quiet mode. If the acoustic levels are regulated, then
the
> power consumption and heat generated also reduces. I did not notice any
> performance degradation. Seagate is shipped with the performance mode
> acoustic level. So, reduce it to quiet mode and see if the temperature is
> reduced
>
> -----Original Message-----
> From: Barry K. Nathan [mailto:barryn@pobox.com]
> Sent: Tuesday, November 19, 2002 7:48 PM
> To: Manish Lachwani
> Cc: 'Steven Timm'; linux-kernel@vger.kernel.org
> Subject: Re: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
>
>
> On Tue, Nov 19, 2002 at 04:08:22PM -0800, Manish Lachwani wrote:
> > I have seen this errors on Seagate ST380021A 80 GB drive on a large
scale
> in
> > our storage systems that make use of 3ware controllers. Seagate claims
the
> > following reasons:
> >
> > 1. Weak Power supply
> > 2. tempeature and heat
> > 3. vibration
>
> You might want to pay particular attention to #2. See below.
>
> > Although, the maxtor 160 GB drives do not show such problems at all.
Such
> > problems can be eliminated though. From the SMART data, get the bad
> sectors
> > and remap them by writing to the raw device. Those pending sectors will
> get
> > remapped. However, the problems will persist with these drives. In our
> > boxes, the operating temperature is abt 55 C ...
>
> Unless they're really really new, the 160GB Maxtor drives are 5400RPM
> so they put out far less heat. (The fact that the Maxtors are
ball-bearing,
> vs. the Seagates' fluid bearings, also helps in this regard --
> fluid-bearing drives tend to dissipate more heat.)
>
> 55 C is technically within the Seagate specs, but it's arguably a bit on
> the high side. If possible, it might be interesting to bring it the
> temperature down several degrees and see if the reliability improves.
>
> -Barry K. Nathan <bnathan@math.uci.edu>
>
