Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265741AbUFDL7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265741AbUFDL7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 07:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUFDL7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 07:59:10 -0400
Received: from mailgate2.sover.net ([209.198.87.64]:23745 "EHLO mx2.sover.net")
	by vger.kernel.org with ESMTP id S265741AbUFDL66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 07:58:58 -0400
Message-ID: <40C06431.8090603@sover.net>
Date: Fri, 04 Jun 2004 07:59:45 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Gerhard Mack <gmack@innerfire.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406031031480.14817@innerfire.net> <20040604093658.GD11034@elte.hu>
In-Reply-To: <20040604093658.GD11034@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Gerhard Mack <gmack@innerfire.net> wrote:
>
>>> kernel tried to access NX-protected page - exploit attempt? (uid: 500)
>>> Unable to handle kernel paging request at virtual address f78d0f40
>>> printing eip:
>>> ...
>>>      
>>>
>>Just a small nitpick...
>>
>>Can you please drop the "- exploit attempt" from the error?  Buffer
>>overflows aren't always exploits.
>>    
>>
>
>this message will only trigger if the kernel tries to _execute_ an
>non-executable kernel page - which almost never happens even considering
>kernel crashes. Normal kernel oopses will still look like they used to.
>  
>
Perhaps the message should read like so:

kernel tried to execute NX-protected page - exploit attempt? (uid: 500)
Unable to handle kernel paging request at virtual address f78d0f40
printing eip:

- Steve

