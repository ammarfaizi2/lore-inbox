Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLMUgy>; Wed, 13 Dec 2000 15:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQLMUgo>; Wed, 13 Dec 2000 15:36:44 -0500
Received: from u-code.de ([207.159.137.250]:42477 "EHLO u-code.de")
	by vger.kernel.org with ESMTP id <S129406AbQLMUgJ>;
	Wed, 13 Dec 2000 15:36:09 -0500
From: Eckhard Jokisch <e.jokisch@u-code.de>
Reply-To: e.jokisch@u-code.de
To: linux-kernel@vger.kernel.org
Subject: Re: [me to]2.4.0-test12 randomly hangs up
Date: Wed, 13 Dec 2000 21:07:23 +0000
X-Mailer: KMail [version 1.1.61]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00121321070701.22766@eckhard>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mit, 13 Dez 2000, Jani Monoses wrote:
> Mine too did this 15 minutes ago.Just moving the mouse around in X and
> suddenly complete freeze.No response to ping either.Such a thing didn't
> happen for a long time to me.The only thing I've changed since test11 is
> compiling fb+fbvesa in.

I made similar experience but it also involved 2.2.18 in combination with
KDE2.0 and ALSA.
The machine "hung" but worked heavily on the HD and after about one hour it
worked abain at least on the console.
One thing I found was the current CVS from ALSA seems to have a bug.

Another thing is tha the 8139too driver prodices
Dec 13 12:34:09 eckhard kernel: eth0: Abnormal interrupt, status 00000006.
Dec 13 12:34:19 eckhard kernel: eth0: Abnormal interrupt, status 00000002.
Dec 13 12:34:44 eckhard last message repeated 7 times
Dec 13 12:35:50 eckhard last message repeated 16 times
Dec 13 12:36:23 eckhard last message repeated 4 times
Dec 13 12:37:49 eckhard last message repeated 15 times
Dec 13 12:38:21 eckhard last message repeated 7 times
Dec 13 12:38:22 eckhard kernel: eth0: Abnormal interrupt, status 00000006.
Dec 13 12:38:24 eckhard kernel: eth0: Abnormal interrupt, status 00000002.

in /var/log/messages and the machine is getting very slow then.
This is even worse when compiled as a module.
With rlt8139 driver this does not happen. The chip is 8139A.

Eckhard Jokisch

-------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
