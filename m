Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVIWGak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVIWGak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 02:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVIWGak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 02:30:40 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:64650 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750707AbVIWGak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 02:30:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=guF1KYUP6poMmwywK/TO7n+mOlTK5MJGWFRoDTo82ln4P3Ck34KtMTTPgBthHQ6BWjxUTm4veDoVv0tNeAoVEOWzDS9DrYPnpP91+Qk33Q537jGpR+cHM08l/8BWlbYdTLQXZXEFhV6+EOToIUt9WUWZ8j65g9t+nr6UDyBcN0k=  ;
Message-ID: <4333A109.2000908@yahoo.com.au>
Date: Fri, 23 Sep 2005 16:30:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: making kmalloc BUG() might not be a good idea
References: <20050922.231434.07643075.davem@davemloft.net>
In-Reply-To: <20050922.231434.07643075.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>I'm sort-of concerned about this change:
>
>    [PATCH] __kmalloc: Generate BUG if size requested is too large.
>
>it opens a can of worms, and stuff that used to generate
>-ENOMEM kinds of failures will now BUG() the kernel.
>
>Unless you're going to audit every user triggerable
>path for proper size limiting, I think we should revert
>this change.
>
>Thanks.
>  
>

Making it WARN might be a good compromise.


Send instant messages to your online friends http://au.messenger.yahoo.com 
