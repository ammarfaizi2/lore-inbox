Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267867AbTBRQ7k>; Tue, 18 Feb 2003 11:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267868AbTBRQ7k>; Tue, 18 Feb 2003 11:59:40 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:56995 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S267867AbTBRQ7j>; Tue, 18 Feb 2003 11:59:39 -0500
Subject: Re: "Unknown HZ value! (0) Assume 100." Wraparound bug?
From: Albert Cahalan <albert@users.sf.net>
To: matt@theBachChoir.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Feb 2003 12:05:52 -0500
Message-Id: <1045587953.3174.278.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bernstein writes:

> Two of our machines (one running 2.4.18-xfs-ipsec, one
> running 2.4.19-pre10-ac2)  started spitting this message
> before some commands (might be in Debian procps 2.0.7-8)
> after an uptime of about 248 days (certainly in the latter
> case, probably the same in the former).
>
> This smells a bit as about 248 is about half of about 497,
> which was a trigger (which I managed to hit :) in the
> mid 2.1.x series for the uptime counter to wrap.

Yep. Debian-unstable has procps-3.1.5 now, which won't emit
this message with 2.4.xx and 2.5.xx kernels. Your system is
still inconsistant though, so rebooting would be a good idea.
(processes may appear to have been started in the future and
run for negative time)

The recent 2.5.xx kernels should be able to handle huge
uptimes better; you'll need the procps-3.1.6 release for
the most recent 2.5.xx kernels though.

http://procps.sf.net/


