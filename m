Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSFDSIF>; Tue, 4 Jun 2002 14:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSFDSIE>; Tue, 4 Jun 2002 14:08:04 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:21679 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315260AbSFDSIA>; Tue, 4 Jun 2002 14:08:00 -0400
Message-ID: <3CFD01F8.B69152E4@nortelnetworks.com>
Date: Tue, 04 Jun 2002 14:07:52 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: packets being dropped in IP stack but no error counts incrementing?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been doing some testing on 2.4.18 and I'm seeing an interesting problem.

I have a test tool that simulates bursty UDP traffic by sending a bunch of
messages and then delaying a while.   If I leave the receiving udp socket at its
normal size, then I can get a significant number of messages just vanishing
between the ethernet driver and the userspace socket.  The driver rx count shows
that all packets were received, but the userspace program doesn't get all of
them.  netstat/ifconfig/iproute2 rx dropped counts do not increase.

Is this design intent, are we messing a counter increment when dropping packets,
or am I not looking at the right counter for these numbers?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
