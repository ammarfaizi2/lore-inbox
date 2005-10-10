Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVJJNyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVJJNyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVJJNyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:54:31 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:26193 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750799AbVJJNya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:54:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=n5kyP80Ph6kg2QIFwQZXu6SmYWMUAKDnBgJ7XG6/aztBa40pLBD/ME+DrGevD1za3/ISzM0aq7CiFBnLM2Id2BBLclE4nJSyHq8ZBgek7ie9DjQqYSXGyBuQS1MFTcfTU6QaHXV/pWPjAT4bbWmbEsJXiv6irwmLlo5qy//+fYQ=  ;
Message-ID: <434A72A8.2000308@yahoo.com.au>
Date: Mon, 10 Oct 2005 23:54:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: WU Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: [RFC] use radix_tree for non-resident page tracking
References: <20051010130705.GA5026@mail.ustc.edu.cn>
In-Reply-To: <20051010130705.GA5026@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WU Fengguang wrote:
> Hi Rik,
> The CLOCK-Pro page replacement is quite appealing, and I'd like to
> contribute an idea: How about store bookkeeping info of dropped pages
> in-place in radix_tree?
> 
> The slots in radix_tree_node can be used for bookkeeping data when
> the corresponding pages are dropped. When all pages in a radix_tree_node
> have been dropped, it is registered in an array/list for delayed
> reclaim.
> 
> It would be fast and simple:
> - no cache-line pollution
> - no extra lock (with Nick Piggin's great RCU improvement)

Just a note if you are looking into this - the last version of the
radix-tree lockless readside patches I made public IIRC had some
bugs in them which I have since fixed.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
