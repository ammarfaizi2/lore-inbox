Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281341AbRKPMGm>; Fri, 16 Nov 2001 07:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281342AbRKPMGc>; Fri, 16 Nov 2001 07:06:32 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:17061 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281341AbRKPMGN>; Fri, 16 Nov 2001 07:06:13 -0500
Date: Fri, 16 Nov 2001 12:06:06 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: Herbert Nachtnebel <Herbert.Nachtnebel@tuwien.ac.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: routing messages [was Athlon SMP blues]
In-Reply-To: <B900970C7DD9474C972986EB3EC7C58F035767@andromeda.agcad.local>
Message-ID: <Pine.GSO.4.33.0111161200540.14971-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> setup on my machine got screwed by a weird interaction between a missing
> kernel config option and the user space tools used by the network setup
> scripts. Before, I never had a usage for the "Routing Messages" option
> in the "Networking Options" kernel configuration. But now, if I don't
> enable it, than the ip utility isn't able to correctly determine the
> network interfaces, hence the network setup script fails and even the
> loopback interface isn't setup correctly. This way no usable network
> connection is available and the login get screwed totally.

Yes, I experienced exactly this problem yesterday. The login hangups
were *not* to do with kernel problems, or overheating, but merely the
'gpm' service trying to play with a non-existent mouse.

After booting the system into Red Hat's canned 2.4.9-13smp, I compiled
2.4.15-pre4 [in about 2.5 minutes :) ]  and rebooted. The machine came
up, but the networking was totally screwed. I rebuilt the kernel, adding
several more config options in the networking section (including
"Routing Messages", and it works beautifully now.

I've since built 2.4.15-pre5, which is also fine. Presumably, this
patch has also fixed most of the merge bugs in -pre4? I had problems
building -pre4 on other machines.

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

