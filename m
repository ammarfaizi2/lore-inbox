Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263403AbTH0OnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbTH0OnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:43:17 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:8321 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id S263403AbTH0OnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:43:15 -0400
Date: Wed, 27 Aug 2003 16:42:56 +0200 (CEST)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 on SMP has extra slow context switch
In-Reply-To: <Pine.LNX.4.33.0308271358200.529-100000@devix>
Message-ID: <Pine.LNX.4.33.0308271634480.529-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New informations. I tested more kernels.
2.4.21 and 22 with 2 CPUs are slow as hell. When I reboot
with maxcpus=1 then all is suddenly ok.
Also floppy drive was not detected in 2 CPU config while
with maxcpus=1 it is.
I placed lmbench data and dmesg output to
http://luxik.cdi.cz/~devik/tmp/slow-smp/ in case someone
knows what to do.
I can do some other tests if you want me to do them.

thanks,
devik

On Wed, 27 Aug 2003, devik wrote:

> Hello,
>
> I upgraded one SMP box (Soyo MB, 2x PII/350, 500MB) from
> 2.4.8 (really) to 2.4.21 last week. Users start to complaint
> that it is slow.
> I run lmbench's context switch measurer and it's result is:
> "size=0k ovr=5.41
> 2 169.26
> 3 111.28
> 4 83.99
>
> While on very similar UP system (the same CPU & kernel) it is:
> "size=0k ovr=3.50
> 2 1.80
> 3 2.08
> 4 2.89
>
> Have someone even idea what is going on ? The systems seems to be
> fairly stable but slooow.
> I plan to reboot with single CPU at evening and/or upgrade to .22,
> but the numbers above are weird.
>
> thanks,
> -------------------------------
>     Martin Devera aka devik
> Linux kernel QoS/HTB maintainer
>   http://luxik.cdi.cz/~devik/
>
>

