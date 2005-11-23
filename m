Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbVKWWW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbVKWWW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbVKWWW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:22:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:54956 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965211AbVKWWWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:22:52 -0500
Message-ID: <4384EB98.5050408@zytor.com>
Date: Wed, 23 Nov 2005 14:22:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>	 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>	 <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>	 <1132764133.7268.51.camel@localhost.localdomain>	 <20051123163906.GF20775@brahms.suse.de>	 <1132766489.7268.71.camel@localhost.localdomain>	 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>	 <4384AECC.1030403@zytor.com>	 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>	 <1132782245.13095.4.camel@localhost.localdomain>	 <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <1132786222.13095.28.camel@localhost.localdomain>
In-Reply-To: <1132786222.13095.28.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2005-11-23 at 13:36 -0800, Linus Torvalds wrote:
> 
>>>have to add PAT support which we need to do anyway we would get a world
>>>where on uniprocessor lock prefix only works on addresse targets we want
>>>it to - ie pci_alloc_consistent() pages.
>>
>>No. That would be wrong.
>>
>>The thing is, "lock" is useless EVEN ON SMP in user space 99% of the time.
> 
> 
> Now I see what you are aiming at, yes that makes vast amounts of sense
> and since AMD have the "no lock effect" bit for general case maybe they
> can
> 

What it really comes down to (virtualization or not!) is whether or not 
the OS can guarantee that nothing else is messing with memory at the 
same time.

This is potentially different from process to process (because of page 
table differences) and from kernel to user space (because of the User 
bit in the page tables.)

	-hpa


