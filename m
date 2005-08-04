Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVHDOdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVHDOdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVHDOb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:31:28 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:42880 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261849AbVHDOaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:30:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Zz2oU1i3yyyLwDu1YYhO1kirJAVOpaFJJ/xNwKb3RHYrSfjVBWdkwiAfwoNL1WZ8slSBXmRXxAzZhIWCZHeAk9e0h7I+p6c8+LKPpoacwxehlG0EV0r9SUga1kkOhwpdQ/3gOkhCuCV1K5IVyvFEDySVKOgrFNEpCN1StXtsheI=  ;
Message-ID: <42F2266F.30008@yahoo.com.au>
Date: Fri, 05 Aug 2005 00:30:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
CC: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
References: <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org> <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com> <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org> <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org> <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org> <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com> <42F09B41.3050409@yahoo.com.au> <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org> <20050804141457.GA1178@localhost.localdomain>
In-Reply-To: <20050804141457.GA1178@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:
> On Wed, Aug 03, 2005 at 09:12:37AM -0700 Linus Torvalds wrote:
> 
> 
>>
>>Ok, I applied this because it was reasonably pretty and I liked the 
>>approach. It seems buggy, though, since it was using "switch ()" to test 
>>the bits (wrongly, afaik), and I'm going to apply the appended on top of 
>>it. Holler quickly if you disagreee..
>>
> 
> 
> x86_64 had hardcoded the VM_ numbers so it broke down when the numbers
> were changed.
> 

Ugh, sorry I should have audited this but I really wasn't expecting
it (famous last words). Hasn't been a good week for me.

parisc, cris, m68k, frv, sh64, arm26 are also broken.
Would you mind resending a patch that fixes them all?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
