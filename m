Return-Path: <linux-kernel-owner+w=401wt.eu-S1753971AbWLXAM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbWLXAM6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 19:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbWLXAM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 19:12:57 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:49870 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971AbWLXAM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 19:12:57 -0500
Date: Sun, 24 Dec 2006 01:12:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: evading ulimits
In-Reply-To: <458C4CEF.3090505@comcast.net>
Message-ID: <Pine.LNX.4.61.0612240111250.20280@yvahk01.tjqt.qr>
References: <458C4CEF.3090505@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I've set up some stuff on my box where /etc/security/limits.conf
>contains the following:
>
>@users          soft    nproc           3072
>@users          hard    nproc           4096
>
>I'm in group users, and a simple fork bomb is easily quashed by this:
>
>bluefox@icebox:~$ :(){ :|:; };:
>bash: fork: Resource temporarily unavailable
>Terminated
>
>Oddly enough, trying this again and again yields the same results; but,
>I can kill the box (eventually; about 1 minute in I managed to `/exec
>killall -9 bash` from x-chat, since I couldn't get a new shell open)
>with the below:

Note that trying to kill all shells is a race between killing them all first
and them spawning new ones everytime. To stop fork bombs, use killall -STOP
first, then kill them.


	-`J'
-- 
