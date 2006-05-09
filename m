Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWEITX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWEITX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWEITX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:23:26 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:54648 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750911AbWEITX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:23:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=JGTbNmbtH3clK+oKr7r5aEJxgqhgrdVynQNbwaDiloYopGhFZ8YpeczXguRwgeM9Wb2ca2YTYdxPvMAnp1AvvtSlqz+XmNZw1hlsfUhnTkGQUZlYrEHuz6O11LyK1vbvjHv13cSsLPthmC4oT96msmVNIYd3cFLGS1uUy9Yvq0w=  ;
Message-ID: <4460AD45.4070608@yahoo.com.au>
Date: Wed, 10 May 2006 00:55:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
References: <20060509084945.373541000@sous-sol.org> <20060509085154.095325000@sous-sol.org> <4460AC06.4000303@mbligh.org>
In-Reply-To: <4460AC06.4000303@mbligh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>> +/*
>> + * The use of 'barrier' in the following reflects their use as 
>> local-lock
>> + * operations. Reentrancy must be prevented (e.g., __cli()) /before/ 
>> following
>> + * critical operations are executed. All critical operations must 
>> complete
>> + * /before/ reentrancy is permitted (e.g., __sti()). Alpha 
>> architecture also
>> + * includes these barriers, for example.
>> + */
> 
> 
> Seems like an odd comment to have in an i386 header file.

Also, it is only talking about compiler barriers, which have nothing
to do with the architecture.

And preempt_* macros should contain the correct compiler barriers, so
several can be removed.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
