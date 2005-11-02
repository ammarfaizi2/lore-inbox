Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVKBXbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVKBXbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVKBXbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:31:12 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:55217 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030200AbVKBXbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:31:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ffPqnmeaa11NH+UJNnDyUljt+z9fmveK1dZcMv7LF7KJqKEARdhDA0mVNkQwNTwqZM5c5PwspKwQBBNkexaHhri7VUkWlTVIQD2Mj7NiHb5Wb/Lkyi7H3F+jSG1SZYvRrSRgL2BjYZ/P5I3NlWdX7Cc/Mn/bw10kMbu3S/I7/6E=  ;
Message-ID: <43694C9A.8010804@yahoo.com.au>
Date: Thu, 03 Nov 2005 10:32:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Dipankar Sarma <dipankar@in.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: bad page state under possibly oom situation
References: <20051102143502.GE6137@in.ibm.com> <Pine.LNX.4.61.0511021614110.10299@goblin.wat.veritas.com> <20051102194800.GM6137@in.ibm.com> <Pine.LNX.4.61.0511022013390.17675@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511022013390.17675@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> 
> Phew!  It seems I'm off the hook (but having said that, I'll probably
> turn out to be guilty in some other way).  Sorry, I don't have any
> ideas (and have never reproduced this here).
> 

PG_dirty should be cleared when the page is freed. In which case,
perhaps you could stick an extra field in struct page which stores
the address of the last guy who did a (Test)SetPageDirty on the
page. Print it in your bad_page handler.

That might get you started.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
