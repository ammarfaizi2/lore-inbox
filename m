Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269093AbUHaUOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269093AbUHaUOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUHaUMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:12:02 -0400
Received: from lax-gate3.raytheon.com ([199.46.200.232]:9704 "EHLO
	lax-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S268985AbUHaULk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:11:40 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFD2470C56.2DA0AD38-ON86256F01.006DC3B0@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Tue, 31 Aug 2004 15:10:41 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 08/31/2004 03:10:43 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>since the latency tracer does not trigger, we need a modified tracer to
>find out what's happening during such long delays. I've attached the
>'user-latency-tracer' patch ontop of -Q5, which is a modification of the
>latency tracer.
Grr. I should have checked before I built with this patch. With this in
I now get the
  kernel: Could not allocate 4 bytes percpu data
messages again. Need to increase that data area so
  #define PERCPU_ENOUGH_ROOM 196608
or something similar (should leave about 50K free for modules).

I will rebuild with this change plus the latest of the others.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

