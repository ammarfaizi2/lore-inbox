Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbUJYWOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUJYWOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUJYWLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:11:02 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:3474 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261974AbUJYWJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:09:02 -0400
Message-ID: <417D7A11.1090806@tmr.com>
Date: Mon, 25 Oct 2004 18:11:29 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
References: <clgc6m$u72$1@gatekeeper.tmr.com><200410221613.35913.ks@cs.aau.dk> <20041024110410.0cf3f80e.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <20041024110410.0cf3f80e.Tommy.Reynolds@MegaCoder.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Reynolds wrote:
> Uttered Bill Davidsen <davidsen@tmr.com>, spake thus:
> 
> 
>>With all the work Nick, Ingo,Con and others are putting into latency and 
>>responsiveness, I don't understand why anyone thinks this is desirable 
>>behavior. The idle loop is the perfect place to perform things like 
>>this, to convert non-productive cycles into performing tasks which will 
>>directly improve response and performance when the task MUST be done. 
> 
> 
> Bill, with respect,
> 
> The idle loop is, by definition, the place to go when there is
> nothing else to do.  Scrubbing memory is, by definition, not
> "nothing", so leave the idle loop alone.
> 
> That's why God, or maybe it was Linus, invented kernel threads.

Did you really not know what I meant here, or are you being pedantic 
about the nomenclature? Yes, obviously implement by thread(s) with 
priority lower than whale shit, the object of which is to do the work 
when no process is waiting for the CPU, and in very small steps so the 
CPU isn't tied up.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
