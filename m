Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVDGOHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVDGOHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVDGOHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:07:00 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:1955 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261854AbVDGOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:06:57 -0400
Message-ID: <42553E7E.8000102@yahoo.com.au>
Date: Fri, 08 Apr 2005 00:06:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: george@mvista.com, mingo@elte.hu,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
References: <20050407124629.GA17268@in.ibm.com> <425530AB.90605@yahoo.com.au> <20050407140040.GD17268@in.ibm.com>
In-Reply-To: <20050407140040.GD17268@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

> 
> Hmm ..I guess we could restrict the max time a idle CPU will sleep taking
> into account its balance interval. But whatever heuristics we follow to 
> maximize balance_interval of about-to-sleep idle CPU, don't we still run the 
> risk of idle cpu being woken up and going immediately back to sleep (because 
> there was no imbalance)?
> 

Yep.

> Moreover we may be greatly reducing the amount of time a CPU is allowed to 
> sleep this way ...
> 

Yes. I was assuming you get some kind of fairly rapidly diminishing
efficiency return curve based on your maximum sleep time. If that is
not so, then I agree this wouldn't be the best method.

-- 
SUSE Labs, Novell Inc.

