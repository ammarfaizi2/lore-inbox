Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270575AbRHITx5>; Thu, 9 Aug 2001 15:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270574AbRHITxr>; Thu, 9 Aug 2001 15:53:47 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:10901
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S270579AbRHITxf>; Thu, 9 Aug 2001 15:53:35 -0400
Message-ID: <3B72EA75.6B06013B@nortelnetworks.com>
Date: Thu, 09 Aug 2001 15:54:29 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart Duncan <sety@perth.wni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ARP's frustrating behavior
In-Reply-To: <5.1.0.14.0.20010808094513.00ab72c8@mailhost> <5.1.0.14.0.20010808103510.00aafbb0@mailhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Duncan wrote:
> 
> >Evidently, this is considered a feature.  However, to turn it off:
> >echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
> 
> I've tried this and it doesn't work.  I understand that arp_filter uses
> routing tables to determine which interfaces should respond to ARP
> queries.  In my case, both interfaces are on the same network.

Interesting.  This works fine on 2.2.17.  It actually uses the ip address to
network device mapping, so that a NIC won't respond to arp requests for
addresses that are not assigned to that NIC.


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
