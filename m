Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRHUBGP>; Mon, 20 Aug 2001 21:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270087AbRHUBGE>; Mon, 20 Aug 2001 21:06:04 -0400
Received: from mail.webmaster.com ([216.152.64.131]:17044 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S270073AbRHUBGA>; Mon, 20 Aug 2001 21:06:00 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <stimits@idcomm.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: /dev/random in 2.4.6
Date: Mon, 20 Aug 2001 18:06:13 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMMEFIDFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3B81955A.C95A271E@idcomm.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why is it required to use only the time between irq's of a single device
> for start/stop times (time delta measurement)? If the time period were
> instead calculated not on the time between irq of a single device, but
> instead start and stop times were based on different device irq's, then
> many pseudo entropy sources could become full entropy sources...to
> accurately/precisely snoop eth0 traffic and determine it's irq would no
> longer be helpful if the time involved the starting of a timer from
> eth0, but the stop (and thus delta) was derived from something else like
> hard drive activity. Force the attacker to monitor more than one irq,
> plus require the attacker to know which irq device corresponds to the
> stop irq of a particular timer.
>
> A variation on the theme would be to rotate which entropy source is used
> as the stop event whenever a pseudo entropy source starts a timer. E.G.,
> eth0 irq starts a timer, and the hard drive is set to stop the timer on

	This makes no difference at all. It comes down to, ultimately, the
difference between adding 'X' and 'Y' to an entropy pool or 'X' and 'X+Y'.
The set 'X','Y' has the same amount of entropy as the set 'X','X+Y'. Either
the time at which events occur contains entropy or it doesn't. No amount of
math can increase the amount of entropy present in those times. Sorry.

	DS

