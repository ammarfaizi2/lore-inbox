Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWFUPb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWFUPb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWFUPb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:31:56 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:34701 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932183AbWFUPbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:31:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ir84YNtBHH67BJZGppK9KkU8Q7Kf6AiOqIK+tjuYSxaegyMaeWYbWow6QacqtQ2Tqo2Ile27aHqEGQ6XJL/pdgWivM3IM8A922EfE69XqbZXMBkjuNJJjomTQdOZhLbXsM0cyLjSg68KzdRz0JTrE9oyLXvSUfgQr3f8u0zk9tQ=  ;
Message-ID: <44996663.80205@yahoo.com.au>
Date: Thu, 22 Jun 2006 01:31:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: bidulock@openss7.org
CC: Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 0/8] Inode diet v2
References: <20060621125146.508341000@candygram.thunk.org> <20060621084217.B7834@openss7.org>
In-Reply-To: <20060621084217.B7834@openss7.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian F. G. Bidulock wrote:
> Theodore,
> 
> On Wed, 21 Jun 2006, Theodore Tso wrote:
> 
> 
>>Unfortunately, since these structures are used by a large amount of
>>kernel code, some of the patches are quite involved, and/or will
>>require a lot of auditing and code review, for "only" 4 or 8 bytes at
>>a time (maybe more on 64-bit platforms).  However, since there are
>>many, many copies of struct inode all over the kernel, even a small
>>reduction in size can have a large beneficial result, and as the old
>>Chinese saying goes, a journey of thousand miles begins with a single
>>step....
> 
> 
> Can you grep inode_cache /proc/slabinfo to see whether you saved any
> memory at all?
> 
> You need to save 48 bytes per inode to fit one more into a slab with
> a 32 byte L1 cache slot; 120 bytes per inode, 64 byte L1 cache slot.

That would be interesting, but I don't think that is necessary. You
have different sizes of types and pages in different architectures
and configurations. Even if there were no immediate savings anywhere,
the inode diet still seems like a worthwhile investigation.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
