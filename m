Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUGYXpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUGYXpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 19:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUGYXpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 19:45:24 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:65465 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S263980AbUGYXpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 19:45:16 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: changing ethernet devices, new one stops cold at iptables
Date: Sun, 25 Jul 2004 19:45:15 -0400
User-Agent: KMail/1.6
References: <Pine.LNX.4.44.0407251149290.25333-100000@filer.marasystems.com> <200407251628.14604.gene.heskett@verizon.net> <410424D5.505@blue-labs.org>
In-Reply-To: <410424D5.505@blue-labs.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407251945.15747.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.153.127.128] at Sun, 25 Jul 2004 18:45:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 July 2004 17:23, David Ford wrote:
>No need to reboot it.  Simply flush the neighbor cache.
>
>Scott root # ip neigh flush help
>Usage: ip neigh { add | del | change | replace } { ADDR [ lladdr
> LLADDR ] [ nud { permanent | noarp | stale | reachable } ]
>
>          | proxy ADDR } [ dev DEV ]
>
>       ip neigh {show|flush} [ to PREFIX ] [ dev DEV ] [ nud STATE ]
>
>David

Is my manpages too old?  I studied it for arp at least half an hour 
without seeing any way out of the dilemma short of a reboot, so I 
did.  And I just checked, theres no linkage from arp to anything 
called 'ip'.  Wrecked a 78 day uptime :(

Yes, I learned something from your message, thank you very much, but 
why is it so deeply buried?

Humm, is there not an option that will a: flush, and then b: refresh 
itself just as if its been rebooted?  The 'replace' appears to 
require intimate knowledge of a 48 bit MAC address etc I'd assume.

 
>Gene Heskett wrote:
>>On Sunday 25 July 2004 05:50, Henrik Nordstrom wrote:
>>>On Thu, 22 Jul 2004, Gene Heskett wrote:
>>>>I can ping the firewall, and I can ssh into it, so that part of
>>>>the network is fine, I just cannot get past iptables in the
>>>>firewall when eth0 is the nforce hardware, which has a different
>>>>MAC address.
>>>
>>>Have you verified that the routing got correctly set up on the new
>>>box?
>>>
>>>  ip ro ls
>>>
>>>The usual cause to the symptoms you describe is that the default
>>>route has gone missing or is invalid.
>>
>>The routing was good, showing the fireall as the default gateway
>>address.
>>
>>In this case, the fix was to reboot the firewall so that its arp
>>tables got refreshed to match the new MAC address of the onboard
>>nforce (forcedeth) nic.  Once that was done, everything was peachy.
>>
>>Thanks, I appreciate the reply, Henrik.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
