Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269332AbUHaX5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269332AbUHaX5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269129AbUHaXyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:54:43 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:9378 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269291AbUHaXr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:47:56 -0400
Date: Wed, 01 Sep 2004 08:53:04 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator without bitmap(2) [0/3]
In-reply-to: <20040831162408.3718c83e.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lhms-devel@lists.sourceforge.net
Message-id: <41350F60.40608@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <41345491.1020209@jp.fujitsu.com>
 <1093969590.26660.4806.camel@nighthawk> <4134FF50.8000300@jp.fujitsu.com>
 <20040831162408.3718c83e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
>>Because I had to record some information about shape of mem_map, I used PG_xxx bit.
>>1 bit is maybe minimum consumption.
> 
> 
> The point is that we're running out of bits in page.flags.
> 
yes.

> You should be able to reuse an existing bit for this application.  PG_lock would suit.

Hmm... PG_buddyend pages in the top of mem_map can be allocated and used as normal pages
,which can be used for Disk I/O.

If I make them as victims to buddy allocator and don't allow to use them,
I can reuse an existing bit.

I'll consider more.

--Kame

