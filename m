Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270557AbTGNHKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270560AbTGNHKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:10:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:22933 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270557AbTGNHKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:10:03 -0400
Date: Mon, 14 Jul 2003 08:24:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy ...
Message-ID: <20030714072449.GE24031@mail.jlokier.co.uk>
References: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com> <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> I also had some sound skips due to inheritance.  If I activate
> xmms's gl visualization under load, it inherits SCHED_SOFTRR, says
> "oink" in a very deep voice, and other xmms threads expire.  Maybe
> tasks shouldn't inherit SCHED_SOFTRR?

That's likely a bug in xmms - it shouldn't be passing the normal
SCHED_RR state to the gl visualizer.

Maybe SOFTRR should penalise the most CPU-using SOFTRR tasks, leaving
the remaining ones in the real-time state.

-- Jamie
