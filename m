Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSJQDGl>; Wed, 16 Oct 2002 23:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSJQDGl>; Wed, 16 Oct 2002 23:06:41 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:12934
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S261663AbSJQDGk>; Wed, 16 Oct 2002 23:06:40 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Michael Clark <michael@metaparadigm.com>
Cc: Simon Roscic <simon.roscic@chello.at>, linux-kernel@vger.kernel.org
In-Reply-To: <3DAD988B.40704@metaparadigm.com>
References: <200210152120.13666.simon.roscic@chello.at>
	 <200210152153.08603.simon.roscic@chello.at>
	 <3DACD41F.2050405@metaparadigm.com>
	 <200210161828.18985.simon.roscic@chello.at>
	 <3DAD988B.40704@metaparadigm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034824350.26.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 22:12:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 11:49, Michael Clark wrote:
> On 10/17/02 00:28, Simon Roscic wrote:
> 
> >>This was happening in pretty much all kernels I tried (a variety of
> >>redhat kernels and aa kernels). Removing LVM has solved the problem.
> >>Although i was blaming LVM - maybe it was a buffer overflow in qla driver.
> > 
> > looks like i had a lot of luck, because my 3 servers wich are using the
> > qla2x00 5.36.3 driver were running without problems, but i'll update to 6.01
> > in the next few day's.
> > 
> > i don't use lvm, the filesystem i use is xfs, so it smells like i had a lot of luck for 
> > not running into this problem, ...

So then, it seems that LVM is adding stress to the system in a way that
is bad for the kernel. Perhaps the read-ahead in conjunction with the
large buffers from XFS, plus the amount of volumes we run(22 on the
latest machine to crash).

> Seems to be the correlation so far. qlogic driver without lvm works okay.
> qlogic driver with lvm, oopsorama.

Michael, what exactly do your servers do? Are they DB servers with ~1Tb
connected, or file-servers with hundreds of gigs, etc?

> ~mc
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
