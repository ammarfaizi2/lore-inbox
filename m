Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRIJNvc>; Mon, 10 Sep 2001 09:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRIJNvX>; Mon, 10 Sep 2001 09:51:23 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:29962 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S269326AbRIJNvH>; Mon, 10 Sep 2001 09:51:07 -0400
Message-ID: <3B9CC525.7E26ABC2@mediascape.de>
Date: Mon, 10 Sep 2001 15:50:29 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.9-ac6 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
In-Reply-To: <200109072337.f87NbPY92715@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I tested it today, compiled 2.4.9ac10 with the new driver and TCQ set
to 32. I built the driver as a module to make sure that the machine at least
boots into runlevel 3 (I have no console access, only access to the reset
switch).

I rebooted and inserted the driver with 'modprobe aic7xxx', remembered that
I forgot the verbose flag, removed the driver with 'modprobe -r' and
re-inserted it with 'modprobe aic7xxx aic7xxx=verbose'. The machine was
still alive then. But right after entering 'raidhotadd /dev/md1 /dev/sda1'
the machine hung. reiserfs erased the last lines of /var/log/messages, but
AFAIK the verbose driver output showed no errors.

But how can I help to reproduce the error? Of course I could break the
mirror, compile the driver into the kernel (non-module) and do some stress
test on the SCSI drive. But it's not so good when I drive this machine into
a hang too often.

I compiled the old driver now, also with TCQ set to 32, and the machine
seems to work fine.

Olaf
