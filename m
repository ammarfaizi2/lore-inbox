Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbTDBVLS>; Wed, 2 Apr 2003 16:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbTDBVLS>; Wed, 2 Apr 2003 16:11:18 -0500
Received: from main.gmane.org ([80.91.224.249]:55695 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S263155AbTDBVLR>;
	Wed, 2 Apr 2003 16:11:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Dennis Cook" <cook@sandgate.com>
Subject: Re: Deactivating TCP checksumming
Date: Wed, 2 Apr 2003 16:22:40 -0500
Organization: Sandgate Technologies
Message-ID: <b6fkaf$t7p$1@main.gmane.org>
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com> <20030401122824.GY29167@mea-ext.zmailer.org> <b6fda2$oec$1@main.gmane.org> <20030402203653.GA2503@gtf.org> <b6fi8m$j4g$1@main.gmane.org> <Pine.LNX.4.53.0304021555160.32710@chaos>
X-Complaints-To: usenet@main.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Cc: kernelnewbies@nl.linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: Windows support of checksum offloading (not kidding).

Following from Windows DDK

===============================================

To achieve a significant performance boost, the Microsoft TCP/IP transport
can offload one or more of the following tasks to a NIC that has the
appropriate task-offload capabilities:

  a.. Checksum tasks
  The TCP/IP transport can offload the calculation and/or validation of IP
and/or TCP checksums. The initial release of Windows® 2000 does not support
UDP checksum offloads; however, future service packs and update releases of
Windows 2000 and later versions may support UDP checksum offloads.


===============================================

Win2K SP3 and WinXP both indicate to my driver that TCP and IP checksums are
being offloaded
on packets to be sent provided the driver advertises that the associated HW
is capable of computing
the checksums. I haven't established that the SW transport stack actually
skips computing the checksums.

"Richard B. Johnson" <root@chaos.analogic.com> wrote in message
news:Pine.LNX.4.53.0304021555160.32710@chaos...
> On Wed, 2 Apr 2003, Dennis Cook wrote:
>
> > What I was looking for is a general capability to keep the SW transport
> > stack from
> > computing outgoing TCP/UDP/IP checksums so that the HW can be allowed to
do
> > it,
> > similar to Windows checksum offload capability.
> REALLY? Who are you kidding. Windows has no such capability.
>
> Check \WINDOWS\SYSTEM32\DRIVERS\ETC\* and see who they stole
> the TCP/IP stack from!
>
> Further, when you perform normal user->TCP/IP operations, you
> get checksumming for free as part of the copy operation. It's
> only when you don't even copy data that you can get any advantage
> of not checksumming. That's why sendfile disables it.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? Think about it.
>



