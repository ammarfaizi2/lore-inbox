Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292150AbSCRTIc>; Mon, 18 Mar 2002 14:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSCRTIW>; Mon, 18 Mar 2002 14:08:22 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:44279 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S292122AbSCRTIK>; Mon, 18 Mar 2002 14:08:10 -0500
Message-ID: <3C963D41.DEC929CC@nortelnetworks.com>
Date: Mon, 18 Mar 2002 14:17:21 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: prade@cs.sunysb.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trapping all Incoming Network Packets
In-Reply-To: <Pine.GSO.4.33.0203181330530.5841-100000@compserv3>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

prade@cs.sunysb.edu wrote:

> I want to sniff the packets, and make a
> decision based on certain characteristics of each packet. So I need to
> have a filter between the IP and link-layer. Also, I do not want the
> filter to slow down traffic. Hence I believe implementing inside kernel
> will be more efficient.

Write a netfilter module and bind it in to NF_IP_PRE_ROUTING or NF_IP_LOCAL_IN
as appropriate.  This will allow you to analyze the packet and decide whether to
keep or discard it (or mangle it if you want).

This is what netfilter is there for.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
