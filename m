Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424194AbWKPPsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424194AbWKPPsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424205AbWKPPsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:48:16 -0500
Received: from mx1.suse.de ([195.135.220.2]:33769 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1424194AbWKPPsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:48:14 -0500
From: Andi Kleen <ak@suse.de>
To: William Cohen <wcohen@redhat.com>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Date: Thu, 16 Nov 2006 16:47:38 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, Eric Dumazet <dada1@cosmosbay.com>,
       Komuro <komurojun-mbn@nifty.com>, Ernst Herzberg <earny@net4u.de>,
       Andre Noll <maan@systemlinux.org>, oprofile-list@lists.sourceforge.net,
       Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <200611160804.31806.ak@suse.de> <455C8520.8060109@redhat.com>
In-Reply-To: <455C8520.8060109@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161647.39456.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What other purposes do you see the performance counters useful for? 

Export one to user space as a cycle counter for benchmarking. RDTSC doesn't 
do this job anymore.

> To collect information on process characteristics so they can be scheduled more efficiently?

That might happen at some point in the future, but i would expect
us to wait for CPUs with more performance counters first.

> Is this going to require sharing the nmi interrupt and knowing which perfcounter 
> register triggered the interrupt to get the correct action?  Currently the 
> oprofile interrupt handler assumes any performance monitoring counter it sees 
> overflowing is something it should count.

Yes. That needs to be fixed.

-Andi

