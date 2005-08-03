Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVHCXIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVHCXIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVHCXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:06:19 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:59310 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261236AbVHCXET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:04:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gmns3SCaxgJW/mW69ohSYTw19GVslQz+7S1pWc9zLTb7xXWNWv42/wqB98ILwNtnqP4LYNJm78emw+9Gisiv7i+Ht6MukdGYxQwJ2VbD4jq3hoSpL7mAJp9BiH1EZCtt+mp+U1EuraZl/ISZAlK2wDTDVdxT0pHp+JygLNneQtM=  ;
Message-ID: <42F14D5F.7040603@yahoo.com.au>
Date: Thu, 04 Aug 2005 09:03:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com> <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org> <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com> <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org> <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org> <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org> <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com> <42F09B41.3050409@yahoo.com.au> <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 3 Aug 2005, Nick Piggin wrote:
> 
>>Oh, it gets rid of the -1 for VM_FAULT_OOM. Doesn't seem like there
>>is a good reason for it, but might that break out of tree drivers?
> 
> 
> Ok, I applied this because it was reasonably pretty and I liked the 
> approach. It seems buggy, though, since it was using "switch ()" to test 
> the bits (wrongly, afaik),

Oops, thanks.

> and I'm going to apply the appended on top of 
> it. Holler quickly if you disagreee..
> 

No that looks fine. Should really be credited to Hugh... well
I guess everyone had some input into it though (Andrew, Hugh,
you, me). It probably doesn't matter too much.

Thanks everyone.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
