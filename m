Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263983AbRFIGdg>; Sat, 9 Jun 2001 02:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263996AbRFIGdZ>; Sat, 9 Jun 2001 02:33:25 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:23820 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S263983AbRFIGdT>; Sat, 9 Jun 2001 02:33:19 -0400
Date: Sat, 9 Jun 2001 06:33:13 +0000 (GMT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B218BA8.6A8C2EB0@uow.edu.au>
Message-ID: <Pine.LNX.4.10.10106090628460.19907-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> reads the RTC device.  The patched RTC driver can then
> measure the elapsed time between the interrupt and the
> read from userspace.  Voila: latency.

interesting, but I'm not sure there's much advantage over
doing it entirely in user-space with the normal /dev/rtc:

	http://brain.mcmaster.ca/~hahn/realfeel.c

it just prints out the raw time difference from when
rtc should have woken up the program.  you can do your own histogram;
for summary purposes, something like stdev is probably best.

