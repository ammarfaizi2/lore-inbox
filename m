Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRJ2NWa>; Mon, 29 Oct 2001 08:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRJ2NWU>; Mon, 29 Oct 2001 08:22:20 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:25731 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S274951AbRJ2NWI>; Mon, 29 Oct 2001 08:22:08 -0500
Message-ID: <001a01c1607d$06aca200$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: <linux-kernel@vger.kernel.org>
Cc: "Laurent Deniel" <deniel@worldnet.fr>
In-Reply-To: <3BDC3F24.4D66FA0A@worldnet.fr>
Subject: Re: Ethernet NIC dual homing
Date: Mon, 29 Oct 2001 14:24:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Laurent Deniel" <deniel@worldnet.fr>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, October 28, 2001 6:23 PM
Subject: Ethernet NIC dual homing


>
> Hi,
>
> Does someone know if there is some work in the area of NIC dual homing ?
> By NIC dual homing, I mean two network devices (e.g. Ethernet) that are
> connected to the same IP subnet but only one is active (at IP level) at a
> time. When a faulty condition is detected (e.g. link down or lack of I/O),
> the kernel switches to the second NIC. Such a similar feature exists in
> Tru64 UNIX (NetRAIN), HP-UX (APA) and Solaris (Sun Cluster pnmd).
> What is the best way to handle that in Linux ? I thought about an IP
virtual
> device that could be mapped on two eternet NIC and some ioctl to switch
from
> one NIC to another or a generic virtual ethernet driver that could handle
two
> real ethernet drivers ?

Well, it shouldn't be too hard to modify the bonding driver to do something
like this (?), and instead the most work should (and will) go into the
user-space daemon. That way it would be possible not only to detect faulty
NIC hardware, but also to detect for example a faulty network segment.

Anyone wants to take a shot on this? I'm gonna look into it a bit, because
it sounds like a nice project for me as a linux-kernel-programmer newbie.

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


