Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVLNBAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVLNBAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbVLNBAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:00:34 -0500
Received: from smtp107.plus.mail.mud.yahoo.com ([68.142.206.240]:65213 "HELO
	smtp107.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932630AbVLNBAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:00:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3FpGC8jn6aJ7AVnKcPlx5GG0uEHpR9w+oRhC4ftCcjYETYmjr9qWFJT9RmUJIUECVUGbk+jwiS1ZuTyyrry61lQ8UU5zxkFp8IkukjEyPvpVj9psnbcSeWe2GRH9Z9whi82+FpFbldCsXXz48P1WhtKIlW1b8r96cEz0EpNqloQ=  ;
Message-ID: <439F6EAB.6030903@yahoo.com.au>
Date: Wed, 14 Dec 2005 12:00:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <439E122E.3080902@yahoo.com.au>  <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com>
In-Reply-To: <22479.1134467689@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>We have atomic_cmpxchg. Can you use that for a sufficient generic
>>implementation?
> 
> 
> No. CMPXCHG/CAS is not as available as XCHG, and it's also unnecessary.
> 

atomic_cmpxchg should be available on all platforms.

While it may be strictly unnecessary, if it can be used to avoid
having a crappy default implementation that requires it to be
reimplemented in all architectures then that would be a good thing.

Any arguments about bad scalability or RT behaviour of the hashed
spinlock emulation atomic_t implementations are silly because they
are used by all atomic_ operations. It is an arch implementation
detail that generic code should not have to worry about.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
