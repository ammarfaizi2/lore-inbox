Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbRATKxp>; Sat, 20 Jan 2001 05:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130359AbRATKxg>; Sat, 20 Jan 2001 05:53:36 -0500
Received: from quechua.inka.de ([212.227.14.2]:12598 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130075AbRATKx1>;
	Sat, 20 Jan 2001 05:53:27 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  available
Message-Id: <E14Jve9-0001jN-00@sites.inka.de>
Date: Sat, 20 Jan 2001 11:53:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A68F855.6F16F152@att.net> you wrote:
> My problem is that if data is NOT available when select()
> starts, but becomes available immediately afterwards, select()
> doesn't wake up immediately, but sleeps for 1/100 second.

It does not sleep for a 1/100second, it will but the process in the run queue
and of course the process needs to wait for the current scheduled process to
finish it's scheduling. This happens only every tick.

If there is no process in the run queue, mabe this can be done faster (already
is done faster?)

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
