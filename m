Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVHBMXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVHBMXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVHBMXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:23:13 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:52881 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261437AbVHBMXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:23:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=WkA56W+7X2ohreO2/sbHlnuCzsP8JLfsfv3yidWe8yR97qWy9iAHr2IIJp+tIWbKOQ38vC7edNB6AIjfyrEsCnxW4wZRquf64IA+R4bMppW2HHN9sfxakR6PehVIh5anTtENj8+sDLf+Ly3vSAqzbXOM9ZVPj5KV1U1/yUcgC0M=  ;
Message-ID: <42EF65A9.1060408@yahoo.com.au>
Date: Tue, 02 Aug 2005 22:23:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jack Steiner <steiner@sgi.com>
Subject: [patch 0/2] sched: reduce locking
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've had these patches around for a while, and I'd like to
get rid of them. They could possibly even go in 2.6.13.

I haven't really done performance testing because it is
difficult to get real workloads going that really stress
these things. There are small improvements on things like
tbench on bigger systems, but nothing greatly interesting.

I think on real workloads, things could get more interesting.

Actually, it would be interesting to know how these go on the
_really_ big systems, and whether lock and cacheline contention
in the scheduler is still a problem for them.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
