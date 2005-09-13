Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVIMQBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVIMQBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVIMQBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:01:38 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:56216 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S964826AbVIMQBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:01:37 -0400
Date: Tue, 13 Sep 2005 18:01:31 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Mark Hounschell <markh@compro.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: HZ question
In-Reply-To: <4326EAD7.50004@compro.net>
Message-ID: <Pine.LNX.4.53.0509131750580.15000@gockel.physik3.uni-rostock.de>
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>
 <4326DB8A.7040109@compro.net> <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de>
 <4326EAD7.50004@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Mark Hounschell wrote:

> On a 100HZ kernel ANY requested delay via udelay or
> pthread_cond_timedwait of less than 10000usecs is unreliable and the the
> actual results are totally unacceptable.
>
> On a 1000HZ kernel the number is 1000 usecs.
>
> I'm not asking the kernel running at 1000hz to actually give me 500 usec
> delay if I ask. I do expect it to be at least 500 usec and within +- a
> single HZ however.

The kernel just cannot guarantee the latter. Rounding is only one of
many issues here.
Do you also want to know about CONFIG_PREEMPT, SMP, current load, future
load in order to estimate the delay you want to ask for?

OTOH, I'm not a soft real-time expert, so I'll stop commenting here.

Tim
