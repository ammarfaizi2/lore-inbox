Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWA3Unv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWA3Unv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWA3Unv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:43:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25759 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964965AbWA3Unu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:43:50 -0500
Message-ID: <43DE7A70.8030004@sgi.com>
Date: Mon, 30 Jan 2006 15:43:28 -0500
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Ingo Molnar <mingo@redhat.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: boot-time slowdown for measure_migration_cost
References: <200601271403.27065.bjorn.helgaas@hp.com> <20060130172140.GB11793@elte.hu> <20060130185301.GA4622@agluck-lia64.sc.intel.com> <20060130192438.GA29129@elte.hu> <20060130200026.GA5081@agluck-lia64.sc.intel.com>
In-Reply-To: <20060130200026.GA5081@agluck-lia64.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tony,

> 
> 
> Might it be wise to see whether the 2% variation that I saw can be
> repeated on some other architecture?   Can someone else try
> this patch and post the before/after values for migration_cost from dmesg?
> 



Ask and ye shall receive ... on the 64p/64G system.

Pristine:

[    9.942253] Brought up 64 CPUs
[    9.942904] Total of 64 processors activated (143654.91 BogoMIPS).
[    9.943995] build_sched_domains: start
[   32.108439] migration_cost=0,32232,39021
[   37.894391] build_sched_domains: end

Patched:

[    0.001307] Calibrating delay loop... 2244.60 BogoMIPS (lpj=4489216)
[    9.942308] Brought up 64 CPUs
[    9.942812] Total of 64 processors activated (143654.91 BogoMIPS).
[   18.080441] migration_cost=0,31934,38750
[   23.865993] checking if image is initramfs... it is

P.

