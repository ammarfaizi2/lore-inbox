Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSEMWoF>; Mon, 13 May 2002 18:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSEMWoE>; Mon, 13 May 2002 18:44:04 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:18115 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S314548AbSEMWoD>; Mon, 13 May 2002 18:44:03 -0400
Date: Mon, 13 May 2002 18:45:06 -0400
To: rml@tech9.net
Cc: linux-kernel@vger.kernel.org, jamagallon@able.es
Subject: Re: [PATCHSET] Linux 2.4.19-pre8-jam2
Message-ID: <20020513184506.A27038@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > - Re-introduction of wake_up_sync to make pipes run fast again. No idea
> > >  about this is useful or not, that is the point, to test it (Randy ?)

> > 2.5 kernels <= 2.5.15 aren't completing umount on the 4 way Xeon.

> Is umount not completing somehow due to the lack of wake_up_sync ???

The umount issue is unrelated to wake_up_sync.  Could be a scsi driver 
issue, as 2.5.x has been fine on my IDE system.  Before the benchmarks,
I mkfs some filesystems and mount and umount them.  Haven't
been able to get past that point with 2.5.x yet.

> Fwiw, I am not sold that reintroducing wake_up_sync is worth it.  The
> benchmark is synthetic and could very well not represent the general
> case in which the load balancer is capable of handling the scenario
> without the hackery of an explicit sync option.

That could well be.  The kernel build test which applies patches
and compiles with -pipe is as close as I have to a general pipe 
test.  The kernel build test has a low variability (~2%) between 
any of the kernels tested on the 4 way box.

It's worth testing wake_up_sync though.  Occasionally there's 
a surprise.

-- 
Randy Hron

