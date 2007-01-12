Return-Path: <linux-kernel-owner+w=401wt.eu-S1751603AbXALEbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbXALEbV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbXALEbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:31:21 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:45391 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751603AbXALEbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:31:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KUSKbBLfMqrQ2jZiTgTFkv4K4bD9hN+dQ/SdBNvs5CDwSovAu3U4sZdEkPXVIt02NHxZB01AaM0kY5ejJMZHdPWCngvWKtz5PYjyLcA6zDaRz5jE4rD4ADR34jlA08mN5K3BZre//VwY5GCjIUbZlLPUQnzHo1ev1cMroTMT2lo=  ;
X-YMail-OSG: hrTgNKIVM1l5XbQ3tSTGatPV9GoDrvCI75SzZ3wGi4H2YYvtruSxaP1LFHbg7XXpeuPF7gXtdpN3vh8QQRgeheOuJ3I9r7sLQcXUqMP8ksXSiBKxeUyvLZPgnSrwrmXHXUTuyNaBE1j6Bu8-
Message-ID: <45A70EF9.40408@yahoo.com.au>
Date: Fri, 12 Jan 2007 15:30:49 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>	 <20070110220603.f3685385.akpm@osdl.org>	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>	 <20070110225720.7a46e702.akpm@osdl.org>	 <45A5E1B2.2050908@yahoo.com.au> <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com> <45A5F157.9030001@yahoo.com.au> <45A6F70E.1050902@tmr.com>
In-Reply-To: <45A6F70E.1050902@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Nick Piggin wrote:
> 
>> Aubrey wrote:
>>
>> Exactly, and the *real* fix is to modify userspace not to make > 
>> PAGE_SIZE
>> mallocs[*] if it is to be nommu friendly. It is the kernel hacks to do 
>> things
>> like limit cache size that are the bandaids.
> 
> 
> Tuning the system to work appropriately for a given load is not a 
> band-aid.

We are talking about about fragmentation. And limiting pagecache to try to
avoid fragmentation is a bandaid, especially when the problem can be solved
(not just papered over, but solved) in userspace.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
