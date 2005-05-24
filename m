Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVEXIDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVEXIDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVEXIDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:03:33 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:7322 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261422AbVEXIDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:03:23 -0400
Message-ID: <4292DFC3.3060108@yahoo.com.au>
Date: Tue, 24 May 2005 18:03:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu>
In-Reply-To: <20050524064522.GA9385@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> 
>>Personally I think interrupt threads, spinlocks as sleeping mutexes 
>>and PI is something we should keep out of the kernel tree. [...]
> 
> 
> it's not really a problem - they integrate nicely. They also found 
> dozens of hard-to-catch bugs already so if you dont care about embedded 
> systems at all then worst-case you can consider it a spinlock debugging 
> mechanism, with the difference that DEBUG_SPINLOCK is far uglier ;) 
> Anyway, this discussion is premature, as i'm not submitting all these 
> patches yet.
> 

Probably the concern is in multiplicative increase in complexity of
configurations and I'm sure the code itself is more complex too.

Of course this is weighed off against the improvements added to the
kernel. I'm personally not too clear on what those improvements are;
a bit better soft-realtime response? (I don't know) What kind of
userbase increase would that allow? .01%, 1.0%...? Is that large
enough to warrant being included in the kernel? Does it even make
technical sense to do this in the general purpose kernel rather than
a specialised solution?

Those are the kinds of questions that will have to be debated (I
guess this mail is directed more towards Daniel than you, Ingo :)).

Nick


