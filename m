Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284619AbRLETzG>; Wed, 5 Dec 2001 14:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284628AbRLETy5>; Wed, 5 Dec 2001 14:54:57 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:26036 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S284625AbRLETyi>; Wed, 5 Dec 2001 14:54:38 -0500
Message-ID: <3C0E7C0D.2F2F93C@nortelnetworks.com>
Date: Wed, 05 Dec 2001 14:57:01 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
Cc: Q A <qarce_mail_lists@yahoo.com>, linux-kernel@vger.kernel.org,
        qarce@yahoo.com
Subject: Re: ARP shows client is given wrong MAC Address for system with 2 NICs
In-Reply-To: <Pine.LNX.3.95.1011205135505.8200A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> You are moving your IP address to another device (MAC address). What
> do you expect?
> 
> You can delete the old entries from your ARP cache, but it has to
> be done for every system that would be affected or you can just wait
> for the ARP cache entry to expire.
> 
>     /sbin/arp -d ipaddress

It is also possible to send out a gratuitous arp packet that will force everyone
else on the subnet to update their arp caches.  This is the normal technique for
moving an IP address from one NIC to another.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
