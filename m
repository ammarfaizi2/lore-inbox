Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWFBJZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWFBJZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWFBJZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:25:25 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:53391 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751357AbWFBJZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:25:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 19:25:05 +1000
User-Agent: KMail/1.9.1
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
References: <000001c68625$614f59a0$0c4ce984@amr.corp.intel.com>
In-Reply-To: <000001c68625$614f59a0$0c4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021925.06089.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 19:17, Chen, Kenneth W wrote:
> What about the part in dependent_sleeper() being so bully and actively
> resched other low priority sibling tasks?  I think it would be better
> to just let the tasks running on sibling CPU to finish its current time
> slice and then let the backoff logic to kick in.

That would defeat the purpose of smt nice if the higher priority task starts 
after the lower priority task is running on its sibling cpu.

-- 
-ck
