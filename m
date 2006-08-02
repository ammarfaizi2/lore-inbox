Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWHBLtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWHBLtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 07:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWHBLtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 07:49:25 -0400
Received: from vvv.conterra.de ([212.124.44.162]:16609 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S1750772AbWHBLtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 07:49:24 -0400
Message-ID: <44D09125.1090901@conterra.de>
Date: Wed, 02 Aug 2006 13:48:53 +0200
From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware disk latency?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote: 
> dean gaudet wrote:
> 
> : my suspicion is the 3ware lacks any sort of "fairness" in its sharing of
> : buffer space between multiple units on the same controller.  and by
> : disabling the write caching it limits the amount of controller memory that
> : the busy disk can consume.
> 
>         Hmm, do you have a battery backup unit for 9550sx? I don't,
> and the 3ware BIOS does not even allow me to enable write caching without it.
> So I don't think the write caching on the controller side is related
> to my problem.
> 
>         I have been able to improve the latency by upgrading the firmware
> to the newest release (wow, they even have a firmware updating utility
> for Linux!).
> 

I just discovered this thread, as I have similar problems
with my 9550sx. I will perform a firmware upgrade tomorrow,
hope that helps. I have a BBU installed, thus my controller
should be able to handle concurrent requests for read and write.

But I also want to understand, what causes this problems. I have
several VMWare servers running on a RAID5 setup. Several times
a day I observe periods of excessive IO-waits and the guest systems
become unusable for a while. I may use "top", but all I see is
the high iowait and 4 idling processors. I not even found which
processes are actually waiting. Is there a way to trace,
which IO requests are pending, their block numbers and the
process ids that issued the requests? I found there are different
IO scheduler available, which have access to all these informations.
Is it possible to plug in some debug module to trace the IO
traffic similar to "strace" for processes?

Dieter.

