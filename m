Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbRE3P14>; Wed, 30 May 2001 11:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbRE3P1q>; Wed, 30 May 2001 11:27:46 -0400
Received: from chiara.elte.hu ([157.181.150.200]:18955 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261297AbRE3P1k>;
	Wed, 30 May 2001 11:27:40 -0400
Date: Wed, 30 May 2001 17:25:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ PATCH ]: disable pcspeaker kernel: 2.4.2 - 2.4.5
In-Reply-To: <3B150369.D47ED28F@pcsystems.de>
Message-ID: <Pine.LNX.4.33.0105301724570.2384-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 May 2001, Nico Schottelius wrote:

> > the default value is 0, that is good enough.
>
> hmm.. I don't think so... value of 1 would be much better, because
> 0 normally disables the speaker.

i confused the value. Yes, an initialization to 1 would be the correct,
ie.:

+++ linux-2.4.5-nc/kernel/sysctl.c      Wed May  9 23:44:30 2001
@@ -48,6 +49,7 @@
 extern int nr_queued_signals, max_queued_signals;
 extern int sysrq_enabled;

+int pcspeaker_enabled = 1;

	Ingo

