Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279579AbRJ2W0B>; Mon, 29 Oct 2001 17:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279580AbRJ2WZv>; Mon, 29 Oct 2001 17:25:51 -0500
Received: from web20501.mail.yahoo.com ([216.136.226.136]:2823 "HELO
	web20501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279579AbRJ2WZe>; Mon, 29 Oct 2001 17:25:34 -0500
Message-ID: <20011029222609.81860.qmail@web20501.mail.yahoo.com>
Date: Mon, 29 Oct 2001 23:26:09 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Ethernet NIC dual homing
To: Laurent Deniel <deniel@worldnet.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BDDB51C.4095AF84@worldnet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently only the link status is used to monitor a
> NIC.
> So it would be nice if an ioctl was available to
> force a NIC switch-over
> (especially in active-backup policy). This could be
> used by a user-space
> daemon in case for instance no traffic is detected.

the 2.4 driver provides a mode which sends ARP packets
to test the link (far more reliable than MII), and the
appropriate ioctl for the NIC switch-over you need. It
is available to user through ifenslave -c bond0 eth0
for example.

> I see that the bonding driver is included in 2.2.18,
> what is its status in 2.4.x ?

well, it works for me each time I download a new
release, but I don't have prod servers on it to test
for a long time, nor have I passed all the intensive
tests that Constantine Gavrilov did when I was working
on 2.2. BTW, the last release (20011026) seems to have
a buggy ifenslave which activates all the NICs flags
(to be confirmed, just seen this today and replaced
with the previous one). If this is confirmed, I'll
mail
Chad about this problem.

If there are still people interested in 2.2, I'll try
to find some time to back-port the switch-over ioctl
from 2.4.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
