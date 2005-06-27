Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVF0I24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVF0I24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVF0I24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:28:56 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:52138 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261943AbVF0I2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:28:50 -0400
Message-ID: <42BFB8BE.20903@yahoo.com.au>
Date: Mon, 27 Jun 2005 18:28:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
References: <42BF9CD1.2030102@yahoo.com.au>	<20050627004624.53f0415e.akpm@osdl.org>	<42BFB287.5060104@yahoo.com.au> <20050627011539.28793896.akpm@osdl.org>
In-Reply-To: <20050627011539.28793896.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Also, the memory usage regression cases that fault ahead brings makes it
>> a bit contentious.
> 
> 
> faultahead consumes no more memory: if the page is present then point a pte
> at it.  It'll make reclaim work a bit harder in some situations.
> 

Oh OK we'll call that faultahead and Christoph's thing prefault then.

I suspect it may still be a net loss for those that are running into
tree_lock contention, but we'll see.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
