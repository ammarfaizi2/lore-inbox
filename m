Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSCRTme>; Mon, 18 Mar 2002 14:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCRTmY>; Mon, 18 Mar 2002 14:42:24 -0500
Received: from [65.201.154.134] ([65.201.154.134]:31576 "EHLO
	EXCHANGE01.domain.ecutel.com") by vger.kernel.org with ESMTP
	id <S292395AbSCRTmI> convert rfc822-to-8bit; Mon, 18 Mar 2002 14:42:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Trapping all Incoming Network Packets
Date: Mon, 18 Mar 2002 14:41:52 -0500
Message-ID: <AF2378CBE7016247BC0FD5261F1EEB210B6A8F@EXCHANGE01.domain.ecutel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Trapping all Incoming Network Packets
Thread-Index: AcHOsITVMsHalLgMTleJfhgApGM1/AABMNeA
From: "Hari Gadi" <HGadi@ecutel.com>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>, <prade@cs.sunysb.edu>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Is it possible to change the packet (add an extra ip header)
and send it back to network bypassing the routing functionality.
I want to do my own routing.( I add the hardware address of the destination machine)

thanks,
Hari.

-----Original Message-----
From: Chris Friesen [mailto:cfriesen@nortelnetworks.com]
Sent: Monday, March 18, 2002 2:17 PM
To: prade@cs.sunysb.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trapping all Incoming Network Packets


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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
