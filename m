Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTJOPp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTJOPp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:45:57 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:37026 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263459AbTJOPp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:45:56 -0400
Message-ID: <3F8D6BB0.7060809@nortelnetworks.com>
Date: Wed, 15 Oct 2003 11:45:52 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: incoming packet latency in 2.4.[18-20]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is an issue with incoming packet latency in the kernels mentioned.

It seems that if you send in a burst of messages, the amount of time it 
takes to wake the listening process is dependent on the size of the 
message burst.  2.4.18-2.4.20 all show this behaviour, 2.6 doesn't.

Some numbers for a udp message size of 2 bytes:

1 packet, average latency 12 usecs
10 packets, average latency 66 usecs
100 packets, average latency 477 usecs

Is this a known issue?  Is there an easy way to fix this, or is it 
something inherent in the 2.4 architecture?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

