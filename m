Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUIVMmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUIVMmS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUIVMmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:42:17 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:25282 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265029AbUIVMlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:41:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Date: Wed, 22 Sep 2004 08:41:34 -0400
User-Agent: KMail/1.7
Cc: Martin Josefsson <gandalf@wlug.westbo.se>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marc Ballarin <Ballarin.Marc@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, netfilter-devel@lists.netfilter.org,
       "David S. Miller" <davem@davemloft.net>
References: <1095721742.5886.128.camel@bach> <Pine.LNX.4.58.0409221347010.23967@tux.rsn.bth.se> <Pine.LNX.4.53.0409220800200.2147@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.53.0409220800200.2147@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409220841.34453.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.153.73.88] at Wed, 22 Sep 2004 07:41:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 September 2004 08:05, Richard B. Johnson wrote:
>On Wed, 22 Sep 2004, Martin Josefsson wrote:
>> On Wed, 22 Sep 2004, Richard B. Johnson wrote:
>> > > Sure, but you have to start somewhere.  Next step will be
>> > > #error.  Then finally remove the whole thing (I don't want to
>> > > remove the whole thing to start with, since that would create
>> > > a silent failure).
>> > >
>> > > Cheers,
>> > > Rusty.
>> > > --
>> >
>> > What replaces the firewall stuff? It can't just "go away"!
>>
>> Ever heard of iptables?
>>
>> /Martin
>
>I guess I'll have to convert 1340 lines of ipchains commands to
>iptables -yech!

Ouch!  If it takes 1340 lines of ipchains commands, a direct 
translation to iptables syntax is both counter-productive and 
extremely wastefull of system resources, cpu in particular.  I 
admittedly have a dsl router in front of my machine, so it does 99% 
of that job, but if I wanted to put up with the idiosyncracies of the 
Roaring Penguin PPPoE, I could skip the router and be just as secure 
with the less than 30 active lines of my present iptables script.  
With the router, I'm invisible to the outside world.  Of course that 
does restrict me some as I've not figured out how to drill a hole 
thru all that to allow a torrent server to function.  The peace of 
mind is worth that loss IMO.  Its been over a year now since 
portsentry-1.1 saw a trigger and logged it.

Humm, thats a lie, from the firewalls /var/log/messages.1 file:

[root@gene root]# grep attackalert /var/log/messages*
/var/log/messages.1:Sep 16 18:09:16 gene portsentry[1159]: 
attackalert: UDP scan from host: home1.bellatlantic.net/199.45.32.43 
to UDP port: 32771
/var/log/messages.1:Sep 16 18:09:16 gene portsentry[1159]: 
attackalert: Host 199.45.32.43 has been blocked via wrappers with 
string: "ALL: 199.45.32.43"
/var/log/messages.1:Sep 16 18:09:17 gene portsentry[1159]: 
attackalert: Host 199.45.32.43 has been blocked via dropped route 
using command: "/sbin/iptables -I INPUT -s 199.45.32.43 -j DROP"
/var/log/messages.1:Sep 16 18:09:17 gene portsentry[1159]: 
attackalert: UDP scan from host: home1.bellatlantic.net/199.45.32.43 
to UDP port: 32771
/var/log/messages.1:Sep 16 18:09:17 gene portsentry[1159]: 
attackalert: Host: home1.bellatlantic.net/199.45.32.43 is already 
blocked Ignoring

Time to send another nastygram to verizon since thats one of their 
nameservers, and clear out that address from the hosts.deny file.

FWIW, the last time that happened, in April 2003, the hack attempt  
trashed a siemans router and I had to replace it with that linksys.  
Must be time to change the user and password in it again too...

FWIW, verizon has apparently a problem keeping their nameservers from 
being hacked.

>I had convert something to ipchains a couple of years ago.
>That's when I only had to kill-off only about 100 spam-hosts.
>
>Now I gotta convert again. Soon they'll be replacing `ls`
>with `echo *` and nothing will work.

Surely you jest?

>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.26 on an i686 machine (5570.56
> BogoMips). Note 96.31% of all statistics are fiction.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
