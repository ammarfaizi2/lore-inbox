Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319242AbSIFRWf>; Fri, 6 Sep 2002 13:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSIFRWf>; Fri, 6 Sep 2002 13:22:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:20878 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319242AbSIFRWe>; Fri, 6 Sep 2002 13:22:34 -0400
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Nivedita Singhvi <niv@us.ibm.com>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
In-reply-to: Your message of Thu, 05 Sep 2002 23:48:42 PDT.
             <18563262.1031269721@[10.10.2.3]> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12464.1031333164.1@us.ibm.com>
Date: Fri, 06 Sep 2002 10:26:04 -0700
Message-Id: <E17nMs2-0003F6-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <18563262.1031269721@[10.10.2.3]>, > : "Martin J. Bligh" writes:
> >    I would think shoving the data down the NIC
> >    and avoid the fragmentation shouldnt give you that much significant
> >    CPU savings.
> > 
> > It's the DMA bandwidth saved, most of the specweb runs on x86 hardware
> > is limited by the DMA throughput of the PCI host controller.  In
> > particular some controllers are limited to smaller DMA bursts to
> > work around hardware bugs.
> 
> I think we're CPU limited (there's no idle time on this machine), 
> which is odd for an 8 CPU 900MHz P3 Xeon, but still, this is Apache,
> not Tux. You mentioned CPU load as another advantage of TSO ... 
> anything we've done to reduce CPU load enables us to run more and 
> more connections (I think we started at about 260 or something, so 
> 2900 ain't too bad ;-)).

Troy, is there any chance you could post an oprofile from any sort
of reasonably conformant run?  I think that might help enlighten
people a bit as to what we are fighting with.  The last numbers I
remember seemed to indicate that we were spending about 1.25 CPUs
in network/e1000 code with 100% CPU utilization and crappy SpecWeb
throughput.

One of our goals is to actually take the next generation of the most
common "large system" web server and get it to scale along the lines
of Tux or some of the other servers which are more common on the
small machines.  For some reasons, big corporate customers want lots
of features that are in a web server like apache and would also like
the performance on their 8-CPU or 16-CPU machine to not suck at the
same time.  High ideals, I know, wanting all features *and* performance
from the same tool...  Next thing you know they'll want reliability
or some such thing.

gerrit
