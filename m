Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTKMMMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 07:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTKMMMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 07:12:50 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:54172 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S263973AbTKMMMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 07:12:49 -0500
Date: Thu, 13 Nov 2003 14:12:43 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 + 2 * P IV Xeon 2.4GHz with HT + SATA + RAID1 =
 scheduler problems
In-Reply-To: <3FB3732A.4060604@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0311131406080.4183@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0311131303500.4183@hosting.rdsbv.ro>
 <3FB36E18.2030105@cyberone.com.au> <Pine.LNX.4.58.0311131345140.4183@hosting.rdsbv.ro>
 <3FB3732A.4060604@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't see an option to just disable HT with a quick grep. acpi=off
> should do it though.
Do you think that disabling ACPI will be some problems with SMP?
I will try with "acpi=off".

> The virtual processors should get a roughly even amount of work done
> AFAIK. I don't think the P4 allows any sort of control over priorities.
But it is stuck because some resources are blocked by the other virtual
CPU, right? So, maybe this is the problem.

> >The problem with HT is the one that I describe here. From time to time a
> >process (mc, bash) is stuck for 2-6 seconds and then comes back. In test8
> >this was more visible.
> Oh, so it is not any sort of disk IO work that is getting stuck? Then
> don't worry about getting the Ctrl Scroll Lock trace...
I will come back with more info.

>
> OK, well yes turn HT off and see if that helps. One other thing which
> springs to mind is that there is some CPU scheduler code that increases
> timeslice grainularity as the CPU count increases. It seems a bit unlikely
> that this is your problem though.
Context switches are very low (~40) and there are ~40-50 processes
running. Only 2-4 processes are cpu-intensive (postgresql).


Thank you!
---
Catalin(ux) BOIE
catab@deuroconsult.ro
