Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbTJOBjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 21:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbTJOBjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 21:39:46 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:7073 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262307AbTJOBjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 21:39:45 -0400
Message-ID: <3F8CA55C.1080203@nortelnetworks.com>
Date: Tue, 14 Oct 2003 21:39:40 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: question on incoming packets and scheduler
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a long-running cpu hog background task, and a high-priority 
critical task that waits on a socket for network traffic.  When a packet 
comes in, I'd like the cpu hog to be swapped out ASAP, rather than 
waiting for the end of the timeslice.  Is there any way to make this happen?

The code paths that I managed to trace didn't seem to be calling the 
scheduler to force the context switch.  Hopefully I missed something.

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

