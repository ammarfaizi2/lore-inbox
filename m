Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262048AbTCVHQa>; Sat, 22 Mar 2003 02:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262051AbTCVHQ3>; Sat, 22 Mar 2003 02:16:29 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:4251 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S262048AbTCVHQ3>; Sat, 22 Mar 2003 02:16:29 -0500
Message-ID: <3E7C105D.80207@nortelnetworks.com>
Date: Sat, 22 Mar 2003 02:27:25 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: increased unix socket latency from 2.4 to 2.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a small test app that simply embeds a timestamp in a message and sends it
to a receiver, who timestamps the receipt and figures out the message delay.
The packet being sent is 40036 bytes long.

In 2.4.20 with default priorities the latency was 302 usec.

In 2.5.63 with default priorities it went up to 841 usec.

In 2.5.65 with default priorities it has gone up to 1210 usec.  If I set
the receiver to a priority of -20, it drops down to about 1037 usec.

Processor is Duron, all kernels built for K7 using gcc 3.2.

Anyone know what's going on here?


Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


