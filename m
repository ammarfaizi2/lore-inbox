Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbUKQNPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbUKQNPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUKQNOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:14:00 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:7959 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262304AbUKQNNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:13:12 -0500
Message-ID: <419B4E51.8050101@tebibyte.org>
Date: Wed, 17 Nov 2004 14:12:49 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, andrea@novell.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, riel@redhat.com,
       mmokrejs@ribosome.natur.cuni.cz, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet>	<4193E056.6070100@tebibyte.org>	<4194EA45.90800@tebibyte.org>	<20041113233740.GA4121@x30.random>	<20041114094417.GC29267@logos.cnet>	<20041114170339.GB13733@dualathlon.random>	<20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>	<419B14F9.7080204@tebibyte.org> <20041117012346.5bfdf7bc.akpm@osdl.org>
In-Reply-To: <20041117012346.5bfdf7bc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton escreveu:
> Please ignore the previous patch and try the below.

Running 2.6.10-rc2-mm1 with just your new patch. It's got through the
first tests, building umlsim whilst simultaneously doing an 'emerge
sync' (this is a Gentoo box). I'll now try harder to break it.

> It looks like Rik's analysis is correct: when the caller doesn't have
> the swap token it just cannot reclaim referenced pages and scans its
> way into an oom.  Defeating that logic when we've hit the highest
> scanning priority does seem to fix the problem and those nice qsbench
> numbers which the thrashing control gave us appear to be unaffected.

I assume Rik's analysis was not copied to the list? If it was I missed 
it. Is your summary fairly complete?

Regards,
Chris R.
