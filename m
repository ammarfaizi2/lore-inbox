Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVDUPy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVDUPy5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDUPy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:54:57 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:41154 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261466AbVDUPy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:54:56 -0400
Message-ID: <4267CC7C.10907@nortel.com>
Date: Thu, 21 Apr 2005 09:53:32 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Steven Rostedt <rostedt@goodmis.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, jdavis@accessline.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bad rounding in timeval_to_jiffies [was: Re: Odd Timer
 behavior in 2.6 vs 2.4  (1 extra tick)]
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>  <1114052315.5058.13.camel@localhost.localdomain>  <1114054816.5996.10.camel@localhost.localdomain>  <20050421095109.A25431@flint.arm.linux.org.uk> <1114080708.5996.16.camel@localhost.localdomain> <Pine.LNX.4.58.0504210752560.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504210752560.2344@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> If you calculate the expected timeout from the time-of-day in the caller,
> your drift not only goes away, but you'll actually be able to handle 
> things like "oops, the machine is under load so I missed an event".

Does mainline have a high precision monotonic wallclock that is not 
affected by time-of-day changes?  Something like "nano/mico seconds 
since boot"?

Chris
