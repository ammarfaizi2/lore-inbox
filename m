Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284639AbRLIXR7>; Sun, 9 Dec 2001 18:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284638AbRLIXRv>; Sun, 9 Dec 2001 18:17:51 -0500
Received: from sushi.toad.net ([162.33.130.105]:935 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S284644AbRLIXR1>;
	Sun, 9 Dec 2001 18:17:27 -0500
Subject: SysRq to abort APM wait?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Dec 2001 18:18:44 -0500
Message-Id: <1007939925.1038.4.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I have a problem with my machine failing
to suspend.  I'll talk about tracking down that
problem in another thread.  In this thread I would
like to ask whether anyone else thinks it would be
useful to have a SysRq key combo that would cause
the apm driver to cease waiting for processes to
reply to standby|suspend events.

What happened to me today (and this is far from the
first time) is the following.  I request a suspend;
apm (the driver) notifies everyone; X processes the
event and blanks the screeen; but some bonehead of
a process fails to respond to the event and apm just
hangs around waiting forever.  That leaves me sitting
in front of a laptop with a blinking "suspending ..."
light and a blanked screen, and X not accepting 
keypresses.

I think it would be useful if under these circumstances
I could SysRq-a to force apm to stop waiting for
responses to the suspend event and to go ahead and
do the suspend.  Event queues would be cleared and anyone
who hadn't responded to the event would have his write
privilege revoked.

Good idea, or dumb idea?


