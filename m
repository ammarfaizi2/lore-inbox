Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbUKPQd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUKPQd2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbUKPQcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:32:03 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:57110 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262032AbUKPQbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:31:01 -0500
Message-ID: <419A2B3A.80702@tebibyte.org>
Date: Tue, 16 Nov 2004 17:30:50 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrea Arcangeli <andrea@novell.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Nick Piggin <piggin@cyberone.com.au>,
       Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de,
       akpm@osdl.org
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random> <20041114202155.GB2764@logos.cnet>
In-Reply-To: <20041114202155.GB2764@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti escreveu:
> If its not the case, increasing the all_unreclaimable "timer" to a higher value
> than 5 seconds will certainly delay the OOM killer such to a point where 
> its not triggered until the VM reclaiming efforts make progress.
[...]
> 
> Chris, can you change the "500*HZ" in mm/vmscan.c balance_pgdat() function
> to "1000*HZ" and see what you get, please?

Changed. FWIW it's been running happily for hours without a single oom, 
including the normally guaranteed build UML test. I'll leave it running 
and see how it goes. The daily cron run is a usually a popular time for 
killing off a few essential daemons (ntpd, sshd &c), in fact I think the 
OOM Killer actually looks forward to it :)

Regards,
Chris R.
