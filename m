Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVKKRtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVKKRtq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVKKRtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:49:46 -0500
Received: from terminus.zytor.com ([192.83.249.54]:18584 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750974AbVKKRtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:49:45 -0500
Message-ID: <4374D99C.1080006@zytor.com>
Date: Fri, 11 Nov 2005 09:49:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz>
In-Reply-To: <20051111103605.GC27805@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>So some 486 processors do have CR4 register.  Allow them to present it in
>>register dumps by using the old fault technique rather than testing processor
>>family.
> 
> 
> I thought Andi commented this as "way too risky", for little
> good. Nested exceptions are evil.
> 									Pavel

I think the 486's that have CR4 are the same that have CPUID, and thus 
can be tested for by the presence of the ID flag.

	-hpa
