Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRKSKNe>; Mon, 19 Nov 2001 05:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277294AbRKSKNY>; Mon, 19 Nov 2001 05:13:24 -0500
Received: from smtprt16.wanadoo.fr ([193.252.19.183]:17631 "EHLO
	smtprt16.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S277228AbRKSKNO>; Mon, 19 Nov 2001 05:13:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Kilobug <kilobug@freesurf.fr>
Subject: Re: [bug report] System hang up with Speedtouch USB hotplug
Date: Mon, 19 Nov 2001 11:12:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165lQB-0001DZ-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try without the preempt patch?

Duncan.

PS: You say "I'm not using binary driver from Alcatel but the free user-mode 
implementation...".  In fact the Alcatel kernel module is open source (GPL)!
Here's the situation as I understand it:

Johan Verrept's driver has two parts: a kernel module and
a user space management utility.  The kernel module is open
source (GPL).  It has problems with SMP and preempt, but
otherwise works well.  The user space management daemon
is closed source. I think the reason it is closed source is that it
uploads some firmware to the modem, and Alcatel wants this
firmware to be closed source.

Benoit Papillault's driver is completely user space (it talks
to the modem through usbdevfs).  However it still uses the
Alcatel closed source binary management code, because
it needs the firmware for the modem.  But I suppose it
probably doesn't run any closed source code on your computer.
I don't know the details of this project well, so take this with
a pinch of salt (actually, you should take my description of
the other project with a pinch of salt too).
