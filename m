Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbULMOuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbULMOuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbULMOuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:50:19 -0500
Received: from fsmlabs.com ([168.103.115.128]:57547 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261191AbULMOuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:50:13 -0500
Date: Mon, 13 Dec 2004 07:50:09 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
cc: Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
In-Reply-To: <20041213112853.GS16322@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0412130740280.22212@montezuma.fsmlabs.com>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz>
 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
 <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org>
 <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com>
 <20041213112853.GS16322@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Andrea Arcangeli wrote:

> You were the one making the case of the NMI, the NMI will screw
> completely any attempt of rearming the TSC accurately (though I don't
> mind too much, like for the sti; hlt, since NMI is pratically impossible
> to trigger in production, if a NMI is fired we've more troubles than the
> 1/HZ latency on a pending wakeup or on the system time taking the
> tangent ;)

I wouldn't say that NMI isn't used in production, if we didn't cater for 
NMI it'd be hard to do high sample rate profiling with Oprofile and 
dynamic-hz. I consider (non)kernel developers profiling code on systems as 
production use.

> (btw, my firewall systemtime will get fixed too by dyanmic-hz HZ=100,
> it's pure waste to keep my firewall at HZ=1000 even if I didn't have
> constant irq-latency of 3/4msec [measured with rdtsc], though I didn't
> mention this yet because dynamic-hz in my firewall case would be a pure
> band-aid, even fixing the tick-lost adjustment would be a band-aid, the
> only thing to fix is the usb irq that runs for 3/4msec without returning).

I have a few personal systems which really would benefit too ;)

Thanks,
	Zwane

