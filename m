Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUCWMaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUCWMaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:30:35 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15555
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262521AbUCWMaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:30:13 -0500
Date: Tue, 23 Mar 2004 13:31:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: dipankar@in.ibm.com, tiwai@suse.de, Robert Love <rml@ximian.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040323123105.GI22639@dualathlon.random>
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080038105.5296.8.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 11:35:06AM +0100, Arjan van de Ven wrote:
> 
> > Reduce bh processing time of rcu callbacks by using tunable per-cpu
> > krcud daemeons.
> 
> why not just use work queues ?

I don't know if work queues are scheduler friendly, but definitely the
rearming tasklets are. Running a dozen callbacks per pass and queueing
any remining work to a rearming tasklet should fix it.
