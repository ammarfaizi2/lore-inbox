Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286220AbRL0GJU>; Thu, 27 Dec 2001 01:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286221AbRL0GJK>; Thu, 27 Dec 2001 01:09:10 -0500
Received: from sgie000400.kiv-webservice.de ([195.226.81.253]:275 "EHLO
	irc.kiv-host.de") by vger.kernel.org with ESMTP id <S286220AbRL0GI7>;
	Thu, 27 Dec 2001 01:08:59 -0500
Message-ID: <4353BABFDF95D311BFC30004AC4CB22AAE342A@sdar000001.kiv-da.de>
From: "Stolle, Martin (KIV)" <MStolle@kiv.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Informix 7.3 and Linux Kernel 2.4
Date: Thu, 27 Dec 2001 07:06:33 +0100
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have the following configuration

SuSE Linux 7.3
Linux Kernel 2.4.x
4GB-Configuration
3 1/8GB RAM
216 GB HD (6*36)
Glibc 2.2.4
Informix 7.30 for Linux 2.2.x / glibc 2.1.3 (of course, for this 
Kernel series and Library release)
400MB Shared Memory (non-resident)


IBM says, it works only with 2.2/glibc 2.1.3,
but we are forced by certain circumstances to use it under 2.4/glibc 2.2.x.
(the software we run doesn't work with higher versions of informix;
the number of users are too high to use it with lower memory)


At first, Informix works quite well, but after a while, especially
after some traffic on the computer (reading the harddisk by "find", 
do a "update statistics" under informix or some exports, the system
starts thrashing.

I found out, that it starts thrashing with kswapd using 50% of processor
power and oninit using another 50%, when low memory runs short.
>From then, the system is very very slow.
The problem isn't so dramatic with kernel releases <=2.4.9, but with higher
releases, including 2.4.17, it is not tolerable.
2.4.17 does not swap to disk, but is still very slow, but kswapd is always
active (without swapping to disk!).

If i make the shared memory resident, the problem is worser than without.

There is always enough high memory free, before the problem occurs.



I could work around the problem by rebooting the computer automatically
in the morning (so that the problem doesn't occur in normal operation).

I don't know it, perhaps it is a silly question, but is it possible
to swap low memory different than high memory?

Or how can I resolve the problem?

Does anyone has an idea?

Greetings,

Martin Stolle
