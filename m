Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVKGXKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVKGXKM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965590AbVKGXKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:10:11 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:41581 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965060AbVKGXKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:10:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wwSqIIiHJVkNJhPxA8fPDfvtQmR96wdup7OxvDh884P6hIBhaNgH+ZWboY0x+Y0MNFgfy+JPoynLhEXVOyZB2beu6p0Xzllf4YmU0rebQCOSz7q30u+V46LtANE6xkroTfumpJMNOFuLV7+fGQgaHn+F1Rg8D+EDqjuXe3BIIOY=  ;
Message-ID: <436FDF41.9090106@yahoo.com.au>
Date: Tue, 08 Nov 2005 10:12:01 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Nikita Danilov <nikita@clusterfs.com>
Subject: Re: [PATCH 3/3] vm: writeout watermarks
References: <4366FA9A.20402@yahoo.com.au> <4366FAF5.8020908@yahoo.com.au> <4366FB24.5010507@yahoo.com.au> <4366FB4B.9000103@yahoo.com.au> <20051107153337.GB17246@logos.cnet>
In-Reply-To: <20051107153337.GB17246@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Nikita has a customer using large percentage of RAM for 
> a kernel module, which results in get_dirty_limits() misbehaviour
> since
> 
>         unsigned long available_memory = total_pages;
> 
> It should work on the amount of cacheable pages instead.
> 
> He's got a patch but I dont remember the URL. Nikita?
> 

Indeed. This patch has a couple of little problems anyway, and
probably does not logicaly belong as part of this series.

I'll work on previous 2 more important patches first.

My patch should probably go on top of more fundamental work
like Nikita's patch.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
