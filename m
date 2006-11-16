Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424012AbWKPPgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424012AbWKPPgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424177AbWKPPgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:36:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37325 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424012AbWKPPgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:36:35 -0500
Message-ID: <455C8520.8060109@redhat.com>
Date: Thu, 16 Nov 2006 10:34:56 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061116032109.GG9579@bingen.suse.de> <20061115210501.feaf230c.akpm@osdl.org> <200611160804.31806.ak@suse.de>
In-Reply-To: <200611160804.31806.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 16 November 2006 06:05, Andrew Morton wrote:
> 
>>On Thu, 16 Nov 2006 04:21:09 +0100
>>Andi Kleen <ak@suse.de> wrote:
>>
>>
>>>>If it's really true that oprofile is simply busted then that's a serious
>>>>problem and we should find some way of unbusting it.  If that means just
>>>>adding a dummy "0" entry which always returns zero or something like that,
>>>>then fine.
>>>
>>>That could be probably done.
>>
>>I'm told that this is exactly what it was doing before it got changed.
> 
> 
> Hmm, ok perhaps that can be arranged again.
> 
> The trouble is that I want to use this performance counter for
> other purposes too, so we would run into trouble again 
> if oprofile keeps stealing it.

What other purposes do you see the performance counters useful for? To collect 
information on process characteristics so they can be scheduled more efficiently?

Is this going to require sharing the nmi interrupt and knowing which perfcounter 
register triggered the interrupt to get the correct action?  Currently the 
oprofile interrupt handler assumes any performance monitoring counter it sees 
overflowing is something it should count.

-Will
