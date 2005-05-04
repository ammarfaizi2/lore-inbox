Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVEDRp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVEDRp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVEDRp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:45:56 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:46978 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261267AbVEDRpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:45:50 -0400
Message-ID: <42790A18.4000008@nortel.com>
Date: Wed, 04 May 2005 11:44:56 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Nishanth Aravamudan <nacc@us.ibm.com>, john stultz <johnstul@us.ibm.com>,
       Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       Darren Hart <dvhltc@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help with the high res timers
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net> <20050503024336.GA4023@ict.ac.cn> <4277EEF7.8010609@mvista.com> <1115158804.13738.56.camel@cog.beaverton.ibm.com> <427805F8.7000309@mvista.com> <20050504001307.GF3372@us.ibm.com> <42790207.30709@mvista.com>
In-Reply-To: <42790207.30709@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:

> The, I think, elegant solution to the timer storm problem is to 
> not restart the timer until the user picks up the prior expiration.  
> This dynamically adjusts the timer response to the amount of machine 
> available at the time.

The disadvantage is that you then lose accuracy since each timer 
interval is increased by some random amount based on system scheduling. 
  What about some kind of ulimit-type thing to specify the minimum 
recurring interval that can be specified?  If root so specifies, you 
could have 1usec interval timers and the system would hang.  This is 
conceptually no different than busy-looping in a SCHED_FIFO task.

Chris
