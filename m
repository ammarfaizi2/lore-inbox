Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUFCNih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUFCNih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 09:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbUFCNih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 09:38:37 -0400
Received: from mail.tmr.com ([216.238.38.203]:30478 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261904AbUFCNig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:38:36 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: why swap at all?
Date: Thu, 03 Jun 2004 09:38:56 -0400
Organization: TMR Associates, Inc
Message-ID: <c9n9dj$ppd$1@gatekeeper.tmr.com>
References: <5D3C2276FD64424297729EB733ED1F7606242C53@email1.mitretek.org> <20040527124145.GD22648@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1086269684 26413 192.168.12.100 (3 Jun 2004 13:34:44 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040527124145.GD22648@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Thu, May 27, 2004 at 08:31:26AM -0400, Piszcz, Justin Michael wrote:
> 
>>If I have 16GB of ram should I use swap?
>>Would swap cause the machine to slow down?
> 
> 
> Yes. You want swap so you can physically relocate anonymous pages in the
> rare case one ends up somewhere it could cause memory pressure against
> allocations that can only be satisfied by a restricted range of memory.

It would seem that the o/s has enough information to separate pages into 
  categories such as 'part of a program,' 'unwritten user write() data,' 
'user read() data sequential," 'user read data random' (read after seek) 
and the like. It would be nice if admins could do tuning on how the o/s 
weights giving these memory. The swappiness tuner is certainly a start, 
in practice it does help with atypical loads.

And Nick's latest stuff against 2.6.7-rc1-mm1 certainly seems to work 
very well on my little 96MB slow box with a few dozen windows open. I 
would call it the best I've run on this box, ever.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
