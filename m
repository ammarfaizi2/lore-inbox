Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSKTDvx>; Tue, 19 Nov 2002 22:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbSKTDvx>; Tue, 19 Nov 2002 22:51:53 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:21517 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265661AbSKTDvw>; Tue, 19 Nov 2002 22:51:52 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB195D@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Barry K. Nathan'" <barryn@pobox.com>,
       Manish Lachwani <manish@Zambeel.com>
Cc: "'Steven Timm'" <timm@fnal.gov>, linux-kernel@vger.kernel.org
Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
Date: Tue, 19 Nov 2002 19:58:44 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, I could also control the temperature of the seagate drives by
operating them in quiet mode. If the acoustic levels are regulated, then the
power consumption and heat generated also reduces. I did not notice any
performance degradation. Seagate is shipped with the performance mode
acoustic level. So, reduce it to quiet mode and see if the temperature is
reduced 

-----Original Message-----
From: Barry K. Nathan [mailto:barryn@pobox.com]
Sent: Tuesday, November 19, 2002 7:48 PM
To: Manish Lachwani
Cc: 'Steven Timm'; linux-kernel@vger.kernel.org
Subject: Re: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }


On Tue, Nov 19, 2002 at 04:08:22PM -0800, Manish Lachwani wrote:
> I have seen this errors on Seagate ST380021A 80 GB drive on a large scale
in
> our storage systems that make use of 3ware controllers. Seagate claims the
> following reasons:
> 
> 1. Weak Power supply
> 2. tempeature and heat
> 3. vibration

You might want to pay particular attention to #2. See below.

> Although, the maxtor 160 GB drives do not show such problems at all. Such
> problems can be eliminated though. From the SMART data, get the bad
sectors
> and remap them by writing to the raw device. Those pending sectors will
get
> remapped. However, the problems will persist with these drives. In our
> boxes, the operating temperature is abt 55 C ...

Unless they're really really new, the 160GB Maxtor drives are 5400RPM
so they put out far less heat. (The fact that the Maxtors are ball-bearing,
vs. the Seagates' fluid bearings, also helps in this regard --
fluid-bearing drives tend to dissipate more heat.)

55 C is technically within the Seagate specs, but it's arguably a bit on
the high side. If possible, it might be interesting to bring it the
temperature down several degrees and see if the reliability improves.

-Barry K. Nathan <bnathan@math.uci.edu>
