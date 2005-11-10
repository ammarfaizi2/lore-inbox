Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVKJATZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVKJATZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVKJATY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:19:24 -0500
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:6273 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751104AbVKJATX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:19:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=N5mIPcaYqPQg/9BzFCkeRnCdedNOLNoOChmrTZQymc1gwaIxfrZl4zLu/Z/xZB/d19WkZt5/t++UtJ57HV+HXpOCdg0aApK4S86TcEiqSDy1E8yOY0kmvjX35k/asCc63M4pvB6Bm89jiseeqiZcRjAxfnmtgMkIPC9jgKZv8js=  ;
Message-ID: <4372928D.80100@yahoo.com.au>
Date: Thu, 10 Nov 2005 11:21:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-mm@vger.kernel.org
Subject: Re: [PATCH 01/16] mm: delayed page activation
References: <20051109134938.757187000@localhost.localdomain> <20051109141432.393114000@localhost.localdomain>
In-Reply-To: <20051109141432.393114000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> When a page is referenced the second time in inactive_list, mark it with
> PG_activate instead of moving it into active_list immediately. The actual
> moving work is delayed to vmscan time.
> 

This is something similar to what Rik and I have both wanted in the
past. In my case it was to simplify and improve the "use once"
streaming io mechanism.

I wouldn't feel comfortable lumping this together with your readahead
work all at once (ditto for some of the other vm changes).

Mabe we should look at making a decision on some of these peripheral
patches before readahead proper.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
