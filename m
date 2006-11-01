Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752440AbWKAVSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbWKAVSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbWKAVSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:18:17 -0500
Received: from zrtps0kp.nortel.com ([47.140.192.56]:52628 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1752440AbWKAVSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:18:15 -0500
Message-ID: <45490F0D.7000804@nortel.com>
Date: Wed, 01 Nov 2006 15:18:05 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Paul Menage <menage@google.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com> <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com> <20061101173356.GA18182@in.ibm.com>
In-Reply-To: <20061101173356.GA18182@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2006 21:18:10.0093 (UTC) FILETIME=[3B58C5D0:01C6FDFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

>>>        - Support limit (soft and/or hard depending on the resource
>>>          type) in controllers. Guarantee feature could be indirectly
>>>          met thr limits.

I just thought I'd weigh in on this.  As far as our usage pattern is 
concerned, guarantees cannot be met via limits.

I want to give "x" cpu to container X, "y" cpu to container Y, and "z" 
cpu to container Z.

If these are percentages, x+y+z must be less than 100.

However, if Y does not use its share of the cpu, I would like the 
leftover cpu time to be made available to X and Z, in a ratio based on 
their allocated weights.

With limits, I don't see how I can get the ability for containers to 
make opportunistic use of cpu that becomes available.

I can see that with things like memory this could become tricky (How do 
you free up memory that was allocated to X when Y decides that it really 
wants it after all?) but for CPU I think it's a valid scenario.

Chris
