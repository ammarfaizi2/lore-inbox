Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270560AbTGNH2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270561AbTGNH2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:28:04 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:19329 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270560AbTGNH2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:28:01 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jul 2003 00:35:22 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy ...
In-Reply-To: <20030714072449.GE24031@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307140032110.3435@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
 <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net> <20030714072449.GE24031@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Jamie Lokier wrote:

> Mike Galbraith wrote:
> > I also had some sound skips due to inheritance.  If I activate
> > xmms's gl visualization under load, it inherits SCHED_SOFTRR, says
> > "oink" in a very deep voice, and other xmms threads expire.  Maybe
> > tasks shouldn't inherit SCHED_SOFTRR?
>
> That's likely a bug in xmms - it shouldn't be passing the normal
> SCHED_RR state to the gl visualizer.
>
> Maybe SOFTRR should penalise the most CPU-using SOFTRR tasks, leaving
> the remaining ones in the real-time state.

Since xmms is unlikely already supporting SOFTRR :) I believe that he did
what I did with RealPlay, let it get the policy for inheritance. In my
case RealPlay (only with sound) did not skip even under thud.c load.



- Davide

