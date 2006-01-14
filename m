Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWANSn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWANSn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWANSn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:43:29 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:38746 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750754AbWANSn3 (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:43:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=QAHGp79nFG2QkZO0Py+gmWhtMgmT0RP56a9fffYI6AulO+mseswtS6g04I9wo09CMnegJej9aemnbdgf2DMhk4hhuwr4Ph9wqDiJ/WGEiK+UPxUaX33f/EInBlQPaeY6XL4UVFhHAUr7bzq2A5JCRIkPk+4f6T1xdbvGv/J4tKs=  ;
Message-ID: <43C9464D.6060509@yahoo.com.au>
Date: Sun, 15 Jan 2006 05:43:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch] mm: cleanup bootmem
References: <43C8F198.3010609@yahoo.com.au> <Pine.LNX.4.64.0601140949460.13339@g5.osdl.org> <43C93CCA.9080503@yahoo.com.au> <43C93DA0.3040506@yahoo.com.au> <Pine.LNX.4.64.0601141011300.13339@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601141011300.13339@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 15 Jan 2006, Nick Piggin wrote:
> 
>>Oh the BITS_PER_LONG batching?
> 
> 
> Yes.
> 
> 
>>			 That's still completely functional after
>>my patch. In fact, as I said in a followup it is likely to work better
>>than with David's change to free batched pages as order-0, because I
>>reverted back to freeing them as higher order pages.
> 
> 
> Ok. Then I doubt anybody will complain. I'm still wondering if some of the 
> other ugliness was due to some simulator strangeness issues, but maybe 

I'm a little unsure. That's what I suspected when I saw David's
changeset was part of an FRV: prefixed batch but wasn't directly
related to FRV code. (ie. normally such a patch would be mm: or
bootmem:)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
