Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVF0JFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVF0JFm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVF0JFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:05:42 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:12453 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261411AbVF0JEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:04:24 -0400
Message-ID: <42BFC10E.50204@yahoo.com.au>
Date: Mon, 27 Jun 2005 19:04:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
References: <42BF9CD1.2030102@yahoo.com.au> <20050627004624.53f0415e.akpm@osdl.org> <42BFB287.5060104@yahoo.com.au> <42BFBF5B.7080301@cisco.com>
In-Reply-To: <42BFBF5B.7080301@cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:
> Nick Piggin wrote:
> [..]
> 
>> However I think for Oracle and others that use shared memory like
>> this, they are probably not doing linear access, so that would be a
>> net loss. I'm not completely sure (I don't have access to real loads
>> at the moment), but I would have thought those guys would have looked
>> into fault ahead if it were a possibility.
> 
> 
> i thought those guys used O_DIRECT - in which case, wouldn't the page 
> cache not be used?
> 

Well I think they do use O_DIRECT for their IO, but they need to
use the Linux pagecache for their shared memory - that shared
memory being the basis for their page cache. I think. Whatever
the setup I believe they have issues with the tree_lock, which is
why it was changed to an rwlock.

-- 
SUSE Labs, Novell Inc.


Send instant messages to your online friends http://au.messenger.yahoo.com 
