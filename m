Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318562AbSGaXkT>; Wed, 31 Jul 2002 19:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318563AbSGaXkT>; Wed, 31 Jul 2002 19:40:19 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.54]:12516 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S318562AbSGaXkS>; Wed, 31 Jul 2002 19:40:18 -0400
Message-Id: <5.1.0.14.2.20020801094111.02776df0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 01 Aug 2002 09:42:15 +1000
To: "David Luyer" <david_luyer@pacific.net.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: RE: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <00c201c23892$1c5fb450$638317d2@pacific.net.au>
References: <1028122125.8510.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:59 PM 31/07/2002 +1000, David Luyer wrote:
>Alan Cox wrote:
> > > procps version is 2.0.7 (Debian 3.0).
> > >
> > > Where's the mistake -- should timer interrupts be on both
> > > CPUs (I think this is the problem), or is procps miscalculating
> > > Hz (seems less likely, someone would have noticed by now...)?
> >
> > HZ on x86 for user space is defined as 100. Its a procps problem
>
>Slight error in my initial diagnosis of why procps is getting Hertz
>wrong tho.  It's not because timer interrupts are only happening
>on one CPU.  It's because it thinks I have 4 CPUs per system, when
>really I only have 2 CPUs per system.

procps is still wrong.

HZ on x86 is 100 by default.
that isn't 100 per CPU, but 100 per second, regardless of whether the timer 
interrupt is distributed between CPUs or serviced on a single CPU.


cheers,

lincoln.

