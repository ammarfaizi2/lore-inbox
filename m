Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVFNGtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFNGtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVFNGtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:49:52 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:2967 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261261AbVFNGtr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:49:47 -0400
Message-ID: <42AE8086.80609@ru.mvista.com>
Date: Tue, 14 Jun 2005 11:00:22 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: dwalker@mvista.com, paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050610223724.GA20853@nietzsche.lynx.com>	 <20050610225231.GF6564@g5.random>	 <20050610230836.GD21618@nietzsche.lynx.com>	 <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com>	 <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com>	 <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com>	 <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com>	 <42ADE334.4030002@opersys.com>	 <1118693033.2725.21.camel@dhcp153.mvista.com>	 <42ADEC0E.4020907@opersys.com> <1118694495.2725.32.camel@dhcp153.mvista.com> <42AE01EA.10905@opersys.com>
In-Reply-To: <42AE01EA.10905@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Daniel Walker wrote:
> 
>>I wouldn't work on RT if mainline integration wasn't on the agenda. 
> 
> 
> Mainline integration IS what I'm talking about. It's just not done
> the same way.
> 
> 
>>There is going to be positive , and negative discussion on this. I think
>>in the end the maintainers (Linus, and Andrew) don't want "people" to
>>get a patch or modification from the outside. It's best if the community
>>is not separated .. If you make a clean integration , and people want
>>what you are doing, there is no reason for it to be rejected.
> 
> 
> I'm not suggesting the separation of the community, I'm suggesting
> a strategy of integration based on the fact that a large portion of
> kernel contributors don't necessarily care about RT, and most don't
> want to care about it in their day-to-day work 
I would suggest that "don't want to care about it" already led and could 
lead to more bugs similar to the bugs discovered due to RT 
enchancements. But the bottom line here is that these bugs are almost 
always bugs in SMP kernel as well about which each kernel developer have 
to worry about.
>(though I think most
> would care that Linux could have an additional spade down its
> sleeve, and would certainly try to help in as much they can from
> time to time.)
> 
> I'm not suggesting asking "people" to get patches from the outside.
> What I'm saying is that those developing mainstream code shouldn't
> need to worry about anything real-time, including modifications to
> locking primitives in headers (be they defined out or in).
> 
> In essence, what you ask can only hold if all kernel developers
> intend for Linux to become QNX. Clearly this isn't going to happen.
> Whatever changes are made to such core functionality as locking
> primitives and interrupt handling can hardly be "transparent"
> simply by wrapping #ifdef CONFIG_X around it in mainstream headers.
Do you hardly working on the kernel patched with RT patch in other 
configurations than PREEMPT_RT? But I'm working and can;t report any 
outstanding issues/degradation. These changes _are_ "transperent" due to 
preemtp modes configurability. So what do you have behind "can hardly be 
"transparent" simply by wrapping #ifdef CONFIG_X around it"?
> 
>>From my point of view, determinism and best overall performance are
> conflicting goals. Having separate derectories for something as
> fundamentally different from best overall performance as determinism
> is not too much to ask.
configurability of the kernel gives you possibily to choose what you 
want in your custom case. Source code organization is a matter of 
whatever else (readability, complexity, separation of completely 
different functionality (but this is not this case), desire for 
community acceptance, etc) but not that determinism and best overall 
performance are conflicting goals. Why don;t you object against SMP 
though it definitly could conflict with goals of desktop kernel 
configurations?

	Eugeny
> Karim


