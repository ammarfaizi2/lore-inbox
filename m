Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbRFCVK2>; Sun, 3 Jun 2001 17:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbRFCUvs>; Sun, 3 Jun 2001 16:51:48 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:29538 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263758AbRFCUvn>; Sun, 3 Jun 2001 16:51:43 -0400
Date: Sun, 3 Jun 2001 16:51:42 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106032051.f53Kpgg10681@devserv.devel.redhat.com>
To: green@linuxhacker.ru, laughing@shared-source.org (Alan Cox),
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
In-Reply-To: <mailman.991555081.25242.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.991555081.25242.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AC> 2.4.5-ac7
> AC> o       Make USB require PCI                            (me)

> How about people from StrongArm sa11x0 port, who have USB host controller
> (in sa1111 companion chip) but do not have PCI?
> Probably there are more such embedded architectures with USB controllers,
> but not PCI bus.

There is nothing that would bind USB to PCI architecturally.
OHCI and UHCI are PCI based, but that's just a matter of
implementation. I think that Alan was unwise at this point.

I know that some small Motorola parts (relatives of 860, perhaps)
do have USB controllers, but I have no idea if PCI is involved.

> How about ISA USB host controllers?

Those, unfortunately, do not exist. I was shopping for one
in vain for a long time. One formiddable difficulty is that
USB bandwidth is larger than ISA, so the only feasible way
to make a HC is to have all TD's in its onboard memory,
as in VGA.

In other follow-up Alan argued in favor of CONFIG_PCI for
a PCI-less machine. It may be a reasonable approach, for
instance JavaStation-1 has no PCI but requires CONFIG_PCI.
It adds a little of useless bloat, that I considered a
necessary evil in the abovementioned case.

-- Pete
