Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUIAMiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUIAMiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIAMe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:34:26 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:2574 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S266214AbUIAMbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:31:45 -0400
Message-ID: <4135C12B.6050208@fr.thalesgroup.com>
Date: Wed, 01 Sep 2004 14:31:39 +0200
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5 - netdev_max_back_log
 is too small
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040830192131.GA12249@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know that you have reduced netdev_max_back_log to 8 to reduce the latency. But 
I think that you should know that I had to set it back to 32 to avoid ethernet 
frame losses on a 3GHz P4 using e1000 (eth0/threaded=1).

My app is still the one with a 20Mbytes/s flow of data and some signal 
processing work. That's only 20% of max Gigabit Ethernet load and 40% of CPU 
time. Not really hot stuff.

So, this were my 2 cents to help you decide how to balance latency and 
throughput. I hope that you can find a good balance or find a way to allow 
people to easily choose their own balance (e.g. maybe there should be a list of 
parameters impacting latency in the Documentation directory).

  please keep on the good work and thanks a lot !

	P.O. Gaillard

