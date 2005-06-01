Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVFAPEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVFAPEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFAPBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:01:25 -0400
Received: from opersys.com ([64.40.108.71]:3090 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261410AbVFAPAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:00:43 -0400
Message-ID: <429DCF96.8020602@opersys.com>
Date: Wed, 01 Jun 2005 11:09:10 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random>
In-Reply-To: <20050601143202.GI5413@g5.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli wrote:
> Then I'm afraid preempt-RT infringe on the patent that they take after
> years of doing that in linux. I'm not a lawyer but you may want to
> check before investing too much on this for the next 15 years. The
> nanokernel thing has happened exactly because they couldn't wrap the cli
> calls to do something different than a cli AFIK. Nanokernel was a nice
> workaround to avoid having to us the patented irq disable redefine.
> 
> I assumed you weren't infringing on the patent and in turn disabling irq
> locally would actually do that, sorry.

This is a touchy topic, and I can see this thread turning into the mother
of all LKML threads with lots of unproductivity on this issue alone ...

Assuming we're talking about the same patent (US5,995,745) the best thing
one can do to understand is read the actual patent claims. There are two
root claims in the patent (1 & 7) and they both start with:

>> A process for running a general purpose computer operating system
>> using a real time operating system, including the steps of:
>>
>> a) providing a real time operating system for running real time
>> tasks and components and non-real time tasks;
>>
>> b) providing a general purpose operating system as one of the
>> non-real time tasks;
>>
>> c) preempting the general purpose operating system as needed for
>> the real time tasks; and
>>
>> d) preventing the general purpose operating system from blocking
>> preemption of the non-real time tasks.

The full text is here:
http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-bool.html&r=12&f=G&l=50&co1=AND&d=ptxt&s1=5995745&OS=5995745&RS=5995745

In my unlawyerly opinion, neither a nanokernel/hypervisor nor PREEMPT_RT
could possibly be interpreted as doing what is claimed above.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
