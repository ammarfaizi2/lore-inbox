Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRA2TB7>; Mon, 29 Jan 2001 14:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132432AbRA2TBw>; Mon, 29 Jan 2001 14:01:52 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:19213 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129532AbRA2TBd>;
	Mon, 29 Jan 2001 14:01:33 -0500
Date: Tue, 30 Jan 2001 03:31:31 -0500
From: Zach Brown <zab@zabbo.net>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: barryn@pobox.com, "Michael B. Trausch" <fd0man@crosswinds.net>,
        Georg Nikodym <georgn@somanetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: Possible Bug:  drivers/sound/maestro.c
Message-ID: <20010130033131.I25752@tetsuo.zabbo.net>
In-Reply-To: <200101262057.MAA02372@cx518206-b.irvn1.occa.home.com> <006d01c087dc$7dd7e670$1a040a0a@zeusinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <006d01c087dc$7dd7e670$1a040a0a@zeusinc.com>; from ttsig@tuxyturvy.com on Fri, Jan 26, 2001 at 04:11:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > have this problem (or a similar one, anyway -- sometimes the sound becomes
> > distorted or comes only through one speaker) under both Linux 2.2 and
> > Win2K. If it was just Linux, I'd assume it was a driver problem, but the

This is a long-standing bug with the maestro2 driver.  

My current theory is that its a race condition where the APUs get
confused while we update their control memory, but this doesn't make
total sense.  Some of the bug reports I get are implying that the sound
is breaking when we're not touching the apu's control mem.  Maybe
implying a nastier silicon bug..

I've been meaning to try implementing a work around to the theoretical
bug, but I've always had trouble triggering it :/

The fun part of this (and why you would see the bug in win2k) is that
the maestro2 is very poorly documented.  I've never heard of anyone
having full docs on the APUs, including the people I've talked to at ESS.
They bought the part from another company.. (and thankfully axed it in
the maestro3)

so we're stabbing in the dark.

- z
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
