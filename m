Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbTJCIUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbTJCIUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:20:06 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9856 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263599AbTJCIUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:20:02 -0400
Date: Fri, 3 Oct 2003 09:19:58 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310030819.h938JwQi000411@81-2-122-30.bradfords.org.uk>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, karim@opersys.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1A58aF-0000iT-00@wisbech.cl.cam.ac.uk>
References: <E1A58aF-0000iT-00@wisbech.cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Keir Fraser <Keir.Fraser@cl.cam.ac.uk>:
> One of the main differences is that we provide resource isolation, so
> that each virtual machine only gets the resources that its sponsor
> paid for. This allows companies providing virtual servers to
> provide differentiated service according to the amount paid.

You might find that that's a dis-advantage as you scale up.  Rather
than having CPU sit idle waiting for whoever paid for it to put it to
use, companies offering virtual servers would probably prefer to
oversubscribe the resources they've got, much like bandwidth is
contended on a DSL line.

For example, say you have an 8-way box running virtual servers.
Rather than sell each customer 1 cpu, let them burst to all 8 when
they need it.  Only when the load would exceed 100% do yo need to give
precedence to those who paid more.  You can sell a virtual 8 way
machine to 8 customers, as long as they realise that it is contended.
Web servers are often idle 90% of the time, but you want the best
performance when they're not.

Sharing resources such as network cards is also likely to be vital for
this to be scalable to any degree.

Both of those points, as well as virtual local networking, are what
make Z/Series boxes attractive for a lot of applications.

What is the performance penalty of running an X86-Xeno port of an OS
natively on the hardware?  Some distributions may not be prepared to
support it in addition to native X86, but if they can make X86-Xeno
their main architecture...

John.
