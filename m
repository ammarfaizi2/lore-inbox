Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTDGUdB (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTDGUdB (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:33:01 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:28635 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262181AbTDGUc7 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 16:32:59 -0400
Message-ID: <3E91E316.1070000@nortelnetworks.com>
Date: Mon, 07 Apr 2003 16:44:06 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
Cc: Mark Mielke <mark@mark.mielke.cc>, Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Schlichter <schlicht@rumms.uni-mannheim.de>,
       linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
References: <PEEPIDHAKMCGHDBJLHKGKEIGCGAA.rwhite@casabyte.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:

> It would be interesting to have the system keep track of page faults for
> each process and then make a ratio of Page_Faults/Program_Size (or maybe
> RSS?).  The smaller this number is the higher its pages are on the priority
> queue.

This sounds quite interesting, and might actually be implementable.

> [ASIDE: The tracking might actually be better by "memory image" instead of
> "process" so that multi-threaded code will compete based on the sum of their
> threads activities...?]

Works for me.  We're dealing with memory here, it might make sense to 
differentiate based on memory.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

