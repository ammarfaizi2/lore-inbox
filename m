Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUGYVWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUGYVWa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 17:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUGYVWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 17:22:30 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:21381 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264502AbUGYVWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 17:22:10 -0400
Message-ID: <410424D5.505@blue-labs.org>
Date: Sun, 25 Jul 2004 17:23:33 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040724
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: changing ethernet devices, new one stops cold at iptables
References: <Pine.LNX.4.44.0407251149290.25333-100000@filer.marasystems.com> <200407251628.14604.gene.heskett@verizon.net>
In-Reply-To: <200407251628.14604.gene.heskett@verizon.net>
Content-Type: multipart/mixed;
 boundary="------------040404080806000502060405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040404080806000502060405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

No need to reboot it.  Simply flush the neighbor cache.

Scott root # ip neigh flush help
Usage: ip neigh { add | del | change | replace } { ADDR [ lladdr LLADDR ]
          [ nud { permanent | noarp | stale | reachable } ]
          | proxy ADDR } [ dev DEV ]
       ip neigh {show|flush} [ to PREFIX ] [ dev DEV ] [ nud STATE ]

David

Gene Heskett wrote:

>On Sunday 25 July 2004 05:50, Henrik Nordstrom wrote:
>  
>
>>On Thu, 22 Jul 2004, Gene Heskett wrote:
>>    
>>
>>>I can ping the firewall, and I can ssh into it, so that part of
>>>the network is fine, I just cannot get past iptables in the
>>>firewall when eth0 is the nforce hardware, which has a different
>>>MAC address.
>>>      
>>>
>>Have you verified that the routing got correctly set up on the new
>>box?
>>
>>  ip ro ls
>>
>>The usual cause to the symptoms you describe is that the default
>>route has gone missing or is invalid.
>>    
>>
>
>The routing was good, showing the fireall as the default gateway 
>address.
>
>In this case, the fix was to reboot the firewall so that its arp 
>tables got refreshed to match the new MAC address of the onboard 
>nforce (forcedeth) nic.  Once that was done, everything was peachy.
>
>Thanks, I appreciate the reply, Henrik.
>
>  
>

--------------040404080806000502060405
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------040404080806000502060405--
