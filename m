Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269798AbUH0A2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269798AbUH0A2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269850AbUH0AXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:23:53 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:26807 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269797AbUH0AWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:22:48 -0400
Date: Fri, 27 Aug 2004 09:27:53 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] buddy allocator without bitmap  [2/4]
In-reply-to: <20040826171840.4a61e80d.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lhms-devel@lists.sourceforge.net, wli@holomorphy.com
Message-id: <412E8009.3080508@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <412DD1AA.8080408@jp.fujitsu.com>
 <1093535402.2984.11.camel@nighthawk> <412E6CC3.8060908@jp.fujitsu.com>
 <20040826171840.4a61e80d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Okay, I'll do more test and if I find atomic ops are slow,
I'll add __XXXPagePrivate() macros.

ps. I usually test codes on Xeon 1.8G x 2 server.

-- Kame

Andrew Morton wrote:
> Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
>>In the previous version, I used SetPagePrivate()/ClearPagePrivate()/PagePrivate().
>>But these are "atomic" operation and looks very slow.
>>This is why I doesn't used these macros in this version.
>>
>>My previous version, which used set_bit/test_bit/clear_bit, shows very bad performance
>>on my test, and I replaced it.
> 
> 
> That's surprising.  But if you do intend to use non-atomic bitops then
> please add __SetPagePrivate() and __ClearPagePrivate()

-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

