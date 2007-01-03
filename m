Return-Path: <linux-kernel-owner+w=401wt.eu-S1750928AbXACQyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbXACQyF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 11:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbXACQyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 11:54:05 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:60765 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932AbXACQyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 11:54:03 -0500
Message-ID: <459BDFA6.4070109@blueyonder.co.uk>
Date: Wed, 03 Jan 2007 16:53:58 +0000
From: Sid Boyce <g3vbv@blueyonder.co.uk>
Reply-To: g3vbv@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jarek Poplawski <jarkao2@o2.pl>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.19 and up to  2.6.20-rc2 Ethernet problems x86_64
References: <20061229063254.GA1628@ff.dom.local> <4595CD1B.2020102@blueyonder.co.uk> <20070102115050.GA3449@ff.dom.local> <459A7AF1.5060702@blueyonder.co.uk> <20070103104814.GA2629@ff.dom.local>
In-Reply-To: <20070103104814.GA2629@ff.dom.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jarek Poplawski wrote:
> On Tue, Jan 02, 2007 at 03:32:01PM +0000, Sid Boyce wrote:
>> Jarek Poplawski wrote:
> ...
>>> If you could send full ifconfig, route -n (or ip route
>>> if you use additional tables) and tcpdump (all packets)
>> >from both boxes while pinging each other and a few words
>>> how it is connected (other cards, other active boxes in
>>> the network?) maybe something more could be found.
> ...
>> Everything is fine with a eepro100 on the 64x2 box that gave the same
>> problem with a nVidia Corporation MCP51 Ethernet Controller (rev a1)
>> using the forcedeth module. On the x86_64 laptop the problem is with a
>> Broadcom NetXtreme BCM5788 using the tg3 module. Switching back to a
>> 2.6.18.2 kernel, there is no problem.
>> With all configurations of cards on both, route -n is the same on all
>> kernels and instantly reports back. With >=2.6.19 on the laptop, netstat
>> -r takes a very long time before returning the information ~30 seconds,
>> instantly on 2.6.18.2.
> 
> This could be a problem with DNS. Could you do all tests
> (including pinging) with -n option?
> 
> I've read your other message on netdev and see you
> have firewall working and addresses from various 
> networks in logs. I think it would be much easier
> to exclude possible network config errors and try
> to isolate pinging problems by connecting (with
> switch or even crossed cable if possible) only 2
> boxes with firewalls and other net devices disabled
> and try to repeat this pinging with tcpdumps.
> 
> Jarek P.
> 
>
It seems >=2.6.19 and the SuSEfirewall are incompatible.

Turning off the firewall on the laptop cured the problem using 
2.6.20-rc2 and 2.6.20-rc3. I thought it was off. On the 64x2 box, the 
firewall is turned off, so I shall have to reconfigure the network to 
use the Gigabit ethernet instead of the eepro100 in case I turned it off 
after seeing the bug on that box, but didn't stop the firewall.
There is still the problem where the ethernet doesn't get configured 
with acpi=off which I shall post to the acpi devel list, but this is not 
a showstopper for me. ifconfig eth0 192.168.10.5 returns SIOCSIFFLAGS: 
Function not implemented.
Thanks and Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

