Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132800AbRDQSNF>; Tue, 17 Apr 2001 14:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132801AbRDQSM4>; Tue, 17 Apr 2001 14:12:56 -0400
Received: from hnlmail3.hawaii.rr.com ([24.25.227.37]:44557 "EHLO
	hawaii.rr.com") by vger.kernel.org with ESMTP id <S132800AbRDQSMw>;
	Tue, 17 Apr 2001 14:12:52 -0400
From: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
Reply-to: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
To: linux-kernel@vger.kernel.org
Date: Tue, 17 Apr 2001 08:14:17 -1000
Subject: Fwd: RE: ARP responses broken!
X-Mailer: DMailWeb Web to Mail Gateway 2.3t, http://netwinsite.com/top_mail.htm
Message-id: <3adc87f9.e7.0@hawaii.rr.com>
X-User-Info: 131.38.214.4
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

****** Forwarded Message Follows *******
>To: "'Christopher Friesen'" <cfriesen@nortelnetworks.com>,   Sampsa Ranta	
<sampsa@netsonic.fi>
>From: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
>Date: Tue, 17 Apr 2001 18:07:41 -0000
>
>I tested this with kernel version 2.2.18 and arp_filter appeared to be
>broken... I enabled it for /proc/sys/net/ipv4/conf/all/arp_filter,
>/proc/sys/net/ipv4/conf/eth0/arp_filter and
>/proc/sys/net/ipv4/conf/eth1/arp_filter and it did not change the arp
>behavior at all.  I enabled hidden and it worked, is there a know problem
>with this functionality?
>
>	Sam Bingner
>	PACAF CSS/SCHE
>	Contractor RSIS
>	DSN	315 449-7889
>	COMM	808 449-7889
>
>
>-----Original Message-----
>From: Christopher Friesen [mailto:cfriesen@nortelnetworks.com]
>Sent: Tuesday, April 17, 2001 4:25 AM
>To: Sampsa Ranta
>Cc: linux-net; linux-kernel
>Subject: Re: ARP responses broken!
>
>
>Sampsa Ranta wrote:
>
>> I have two interfaces that share same subnet, I call eth0 194.29.192.37
>> and eth1 194.29.192.38. I have forwarding turned on, proxy arp is not
>> neighter are redirects.
>> 
>> When I flush local neighbor table in other machine I use to observe the
>> response and ping the router I get response like:
>> 
>> 23:38:25.278848 > arp who-has 194.29.192.38 tell 194.29.192.10
>(0:50:da:82:ae:9f)
>> 23:38:25.278988 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:64
>(0:50:da:82:ae:9f)
>> 23:38:25.279009 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:6c
>(0:50:da:82:ae:9f)
>> 
>> The second one is the valid one, but both interfaces seem to answer to the

>> broadcasted packet with their own ARP addresses.
>
>This is the default Linux behaviour.  It can be turned off by running the
>following command as root:
>
>echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
>
>This ensures that interfaces will only respond to arp requests for IP
>addresses
>which are configured as belonging to that particular interface.
>
>Chris
>
>-- 
>Chris Friesen                    | MailStop: 043/33/F10  
>Nortel Networks                  | work: (613) 765-0557
>3500 Carling Avenue              | fax:  (613) 765-2986
>Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in

>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
