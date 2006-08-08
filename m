Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWHHQe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWHHQe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWHHQe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:34:56 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:28768 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030189AbWHHQe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:34:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VuqQwaHG/rMRmGvr4440G3O+GmCarJTKPybTWLJFiPaHMH0v8WEciTcgLYeCmOWHjKPV2e3Dj+DhiFcFN4SWNQBpp/X+SYUsTo5EWUWurBB6XAH77VHSyj0W7ZPCVBecZoP4R0mTXG5F2tChSu+CnCnjeDcafTzcrOmH+tu+jho=  ;
Message-ID: <44D8BD29.4010102@yahoo.com.au>
Date: Wed, 09 Aug 2006 02:34:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] NUMA futex hashing
References: <20060808070708.GA3931@localhost.localdomain> <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com> <44D8A9BE.3050607@yahoo.com.au> <200608081808.34708.dada1@cosmosbay.com>
In-Reply-To: <200608081808.34708.dada1@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:

> We certainly can. But if you insist of using mmap sem at all, then we have a 
> problem.
> 
> rbtree would not reduce cacheline bouncing, so :
> 
> We could use a hashtable (allocated on demand) of size N, N depending on 
> NR_CPUS for example. each chain protected by a private spinlock. If N is well 
> chosen, we might reduce lock cacheline bouncing. (different threads fighting 
> on different private futexes would have a good chance to get different 
> cachelines in this hashtable)

See other mail. We already have a hash table ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
