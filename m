Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbVKPBod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVKPBod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVKPBod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:44:33 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:10706 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965153AbVKPBoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:44:32 -0500
Message-ID: <437A8FED.3080508@watson.ibm.com>
Date: Tue, 15 Nov 2005 20:48:29 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
References: <43796596.2010908@watson.ibm.com>	<20051114202017.6f8c0327.akpm@osdl.org> <17274.34333.348600.111728@wombat.chubb.wattle.id.au>
In-Reply-To: <17274.34333.348600.111728@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:
>>>>>>"Andrew" == Andrew Morton <akpm@osdl.org> writes:
> 
> 
> Andrew> Shailabh Nagar <nagar@watson.ibm.com> wrote:
> 
>>> + *ts = sched_clock();
> 
> 
> Andrew> I'm not sure that it's kosher to use sched_clock() for
> Andrew> fine-grained timestamping like this.  Ingo had issues with it
> Andrew> last time this happened?
> 
> It wasn't Ingo, it was Andi Kleen...  for my Microstate Accounting
> patches, which do very similar things to Shailabh's patchsetm, but
> using /proc and a system call instead (following Solaris's lead)
> 

Were these the comments from Andi to which you refer:
	http://www.uwsg.indiana.edu/hypermail/linux/kernel/0503.1/1237.html

The objections to microstate overhead seemed to stem from the syscall
overhead, not use of sched_clock() per se.


Andi, Ingo,

Are there problems with using sched_clock()for timestamping if one is prepared
to live with them not necessarily being nanosecond accurate ? I'm trying to search
the archives etc. but if you can respond with any quick comments, that'd be very
helpful.


Thanks,
Shailabh

