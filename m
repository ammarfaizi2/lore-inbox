Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUJFEJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUJFEJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUJFEJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:09:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56717 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266888AbUJFEJB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:09:01 -0400
Message-ID: <41636FCF.3060600@pobox.com>
Date: Wed, 06 Oct 2004 00:08:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org> <20041006031726.GK26820@dualathlon.random> <4163660A.4010804@pobox.com> <20041006040323.GL26820@dualathlon.random>
In-Reply-To: <20041006040323.GL26820@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Tue, Oct 05, 2004 at 11:27:06PM -0400, Jeff Garzik wrote:
> 
>>You're ignoring the argument :)
>>
>>If users and developers are presented with the _impression_ that long 
>>latency code paths don't exist, then nobody is motivated to profile them 
>>(with any tool), much less fix them.
> 
> 
> well, you are assuming those latencies are visible with eyes. they might
> be in extreme cases, but normally they're not (what people notices
> normally are disk latencies, and few people uses an RT userspace
> anyways which means they cannot claim the problem to be a lack of
> cond_resched, but more likely they want shorter timeslices in the
> scheduler etc..). So my point is that you need a measurement tool anyways...


I do agree with that.

I don't think that implies preempt is useful for anything except hiding 
stuff that should be fixed anyway, though...

Preempt will always be something I ask people to turn off when reporting 
driver bugs; it just adds too much complicated mess for zero gain.

	Jeff


