Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268876AbRHBKaU>; Thu, 2 Aug 2001 06:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268878AbRHBKaK>; Thu, 2 Aug 2001 06:30:10 -0400
Received: from ns.caldera.de ([212.34.180.1]:2255 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268876AbRHBK37>;
	Thu, 2 Aug 2001 06:29:59 -0400
Date: Thu, 2 Aug 2001 12:20:35 +0200
Message-Id: <200108021020.f72AKZC17605@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: Andrej.Borsenkow@mow.siemens.ru (Borsenkow Andrej)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent device numbers
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <000901c11b1c$a87b1f40$21c9ca95@mow.siemens.ru>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <000901c11b1c$a87b1f40$21c9ca95@mow.siemens.ru> you wrote:
> As far as I understand, currently kernel assigns device numbers dynamically.
> It means, that actual, user visible, controller/drive name may change if
>
> - hardware configuaration is changed (added ot removed controller, added or
> removed drive)
>
> - for some reasons order of initialisation in kernel changes (which may
> result in nasty surprise after update)
>
> Moreover, it near to impossible to know which name device gets in advance
> (or why it gets this name).
>
> Most commercial systems (O.K. those I looked into) have some sort of logical
> device numbering that assigns fixed name based on some unique hardware
> address (cf /etc/path_to_inst in Solaris). Hardware address usually is a
> path needed to access device - i.e. Bus/Slot/Channel[/drive id], so that you
> can set
>
> PCI0/Slot3/Channel1 == eth3
>
> and this never changes if you add or remove any card.
>
> Do I miss something and Linux has such mechanism?

For some device-types this is provided be userspace tools.  E.g. LVM
provides persistan names for it's deice by stroing name and UUID on disk,
'normal' filesystems can be mounted by UUID or label and Andi Kleen has
a tool that allows naming network interfaces by MAC addresses.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
