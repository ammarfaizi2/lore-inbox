Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSKTDtE>; Tue, 19 Nov 2002 22:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbSKTDtE>; Tue, 19 Nov 2002 22:49:04 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:20237 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265643AbSKTDtD>; Tue, 19 Nov 2002 22:49:03 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB195C@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Barry K. Nathan'" <barryn@pobox.com>,
       Manish Lachwani <manish@Zambeel.com>
Cc: "'Steven Timm'" <timm@fnal.gov>, linux-kernel@vger.kernel.org
Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
Date: Tue, 19 Nov 2002 19:55:55 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I have done the experiment where if the operating temperature is 50 C
or lesser, there are far lesser errors. However, I also found that the power
supply we were using was weak and if too many drives seek at the same time,
the power supply was not able to deliver current causing such errors. 

After correcting the power supplies, there was one more problem with the
shorting of the leads of the disk controller. On shorting, the current was
drained from that path and enough current could not be delivered to the
drive that was seeking. However, in case of onboard IDE controllers, I dont
thiks that would apply ...



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
