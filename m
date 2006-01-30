Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWA3Uyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWA3Uyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWA3Uyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:54:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24485 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964979AbWA3Uym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:54:42 -0500
Message-ID: <43DE7CA9.5070608@sgi.com>
Date: Mon, 30 Jan 2006 15:52:57 -0500
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prarit Bhargava <prarit@sgi.com>
CC: "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@elte.hu>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@redhat.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: boot-time slowdown for measure_migration_cost
References: <200601271403.27065.bjorn.helgaas@hp.com> <20060130172140.GB11793@elte.hu> <20060130185301.GA4622@agluck-lia64.sc.intel.com> <20060130192438.GA29129@elte.hu> <20060130200026.GA5081@agluck-lia64.sc.intel.com> <43DE7A70.8030004@sgi.com>
In-Reply-To: <43DE7A70.8030004@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prarit Bhargava wrote:
> 
> Tony,
> 
>>
>>
>> Might it be wise to see whether the 2% variation that I saw can be
>> repeated on some other architecture?   Can someone else try
>> this patch and post the before/after values for migration_cost from 
>> dmesg?
>>

Whoops.  Let's try that again:

Pristine (with build_sched_domains measurement):


[    9.942253] Brought up 64 CPUs
[    9.942904] Total of 64 processors activated (143654.91 BogoMIPS).
[    9.943995] build_sched_domains: start
[   32.108439] migration_cost=0,32232,39021
[   37.894391] build_sched_domains: end

Patched (with build_sched_domains measurement):

[    9.942267] Brought up 64 CPUs
[    9.942930] Total of 64 processors activated (143654.91 BogoMIPS).
[    9.944032] build_sched_domains: beginmigration_cost=0,31854,38739
[   23.868304] build_sched_domains: end


P.

> 

