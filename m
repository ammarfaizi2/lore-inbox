Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVF0IDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVF0IDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVF0IDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:03:19 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:46014 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261914AbVF0IDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:03:11 -0400
Message-ID: <42BFB2BC.7070402@yahoo.com.au>
Date: Mon, 27 Jun 2005 18:03:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: VFS scalability
References: <42BF9CD1.2030102@yahoo.com.au> <42BFA014.9090604@yahoo.com.au> <p733br4w9uw.fsf@verdi.suse.de> <42BFABD7.5000006@yahoo.com.au> <20050627074414.GB14251@wotan.suse.de>
In-Reply-To: <20050627074414.GB14251@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, Jun 27, 2005 at 05:33:43PM +1000, Nick Piggin wrote:
> 
>>>Maybe adding a prefetch for it at the beginning of sys_read() 
>>>might help, but then with 64CPUs writing to parts of the inode
>>>it will always thrash no matter how many prefetches.
>>>
>>
>>True. I'm just not sure what is causing the bouncing - I guess
>>->f_count due to get_file()?
> 
> 
> That's in the file, not in the inode. It must be some inode field.
> I don't know which one.
> 

Oh yes, my mistake.

> There is probably some oprofile/perfmon event that could tell
> you which function dirties the cacheline.
> 

I'll see if I can work it out. Thanks.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
