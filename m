Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVFBOVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVFBOVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 10:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVFBOVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 10:21:30 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:3035 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261360AbVFBOV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 10:21:28 -0400
Message-ID: <429F15DA.8030205@nortel.com>
Date: Thu, 02 Jun 2005 08:21:14 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Robert Love <rml@novell.com>, Mikael Starvik <mikael.starvik@axis.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Accessing monotonic clock from modules
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>	 <1117697423.6458.18.camel@laptopd505.fenrus.org>	 <1117698045.6833.16.camel@jenny.boston.ximian.com>	 <1117698518.6458.21.camel@laptopd505.fenrus.org>	 <1117698764.6833.26.camel@jenny.boston.ximian.com>	 <1117698978.6458.23.camel@laptopd505.fenrus.org>	 <429F0DA7.40006@nortel.com> <1117720095.6458.41.camel@laptopd505.fenrus.org>
In-Reply-To: <1117720095.6458.41.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2005-06-02 at 07:46 -0600, Chris Friesen wrote:

>>For ourselves we implemented an clock interface for a limited subset of 
>>architectures that provides a fast timestamp in kernel and userspace.
>>
>>Basically it has one call to return a 64-bit timestamp, and another call 
>>to tell you how fast the clock is ticking.
> 
> 
> hmm this is tricky if cpufreq actually varies cpu speeds... you would
> need to not cache the "how fast it ticks" for too long.

Luckily we didn't need to deal with that.

In order to use the fast versions with varying frequency you'd need some 
kind of notification to all users when the frequency changes.

Alternately, on architectures where clock_gettime doesn't require the 
overhead of a syscall, you could just use that.

Chris
