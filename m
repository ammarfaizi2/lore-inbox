Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVEYRi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVEYRi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVEYRi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:38:28 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:11410 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261509AbVEYRiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:38:15 -0400
Message-ID: <4294B7ED.2030307@nortel.com>
Date: Wed, 25 May 2005 11:37:49 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: bhavesh@avaya.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
References: <1116975555.2050.10.camel@cof110earth.dr.avaya.com> <4294B42D.2020008@mvista.com>
In-Reply-To: <4294B42D.2020008@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Bhavesh P. Davda wrote:
>> setitimer for 20ms was firing at 21ms

> If we do NOT account for this PIT issue, the result is a time drift that 
> is outside of what ntp can handle...

Still, it is non-intuitive that a multi-GHz machine can't wake you up 
more accurately than 1ms.

What about telling it to wake up a jiffy earlier, then checking whether 
the scheduling lag was enough to cause it to have waited the full 
specified time.  If not, put it to sleep for another jiffy.

Chris
