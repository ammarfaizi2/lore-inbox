Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUJFEC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUJFEC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUJFEC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:02:57 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:31460 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266879AbUJFECa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:02:30 -0400
Date: Wed, 6 Oct 2004 06:03:23 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA))
Message-ID: <20041006040323.GL26820@dualathlon.random>
References: <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org> <20041006031726.GK26820@dualathlon.random> <4163660A.4010804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4163660A.4010804@pobox.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 11:27:06PM -0400, Jeff Garzik wrote:
> You're ignoring the argument :)
> 
> If users and developers are presented with the _impression_ that long 
> latency code paths don't exist, then nobody is motivated to profile them 
> (with any tool), much less fix them.

well, you are assuming those latencies are visible with eyes. they might
be in extreme cases, but normally they're not (what people notices
normally are disk latencies, and few people uses an RT userspace
anyways which means they cannot claim the problem to be a lack of
cond_resched, but more likely they want shorter timeslices in the
scheduler etc..). So my point is that you need a measurement tool anyways...
