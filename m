Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbSLEXuf>; Thu, 5 Dec 2002 18:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbSLEXuf>; Thu, 5 Dec 2002 18:50:35 -0500
Received: from HIC-SR1.hickam.af.mil ([131.38.214.75]:30086 "EHLO
	hic-sr1.hickam.af.mil") by vger.kernel.org with ESMTP
	id <S267437AbSLEXud>; Thu, 5 Dec 2002 18:50:33 -0500
Message-ID: <A6B0BFA3B496A24488661CC25B9A0EFA333DF7@himl07.hickam.pacaf.ds.af.mil>
From: Bingner Sam J Contractor PACAF CSS/SCHE 
	<Sam.Bingner@hickam.af.mil>
To: "'Roberto Nibali'" <ratz@drugphish.ch>,
       Phil Oester <kernel@theoesters.com>
Cc: "David S. Miller" <davem@redhat.com>, "'ja@ssi.bg'" <ja@ssi.bg>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: RE: hidden interface (ARP) 2.4.20
Date: Thu, 5 Dec 2002 23:57:18 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to risk getting jumped on again, I still don't see why an address that is
-=ASSIGNED TO AN INTERFACE=- should be responded to on a completely
different interface... if we wanted the ip address to be assigned to the
system, there should be a pseudo interface that will work on any of the
interfaces attached.  Why assign an address to an interface if it would work
just the same if you assigned it to the loopback adapter?  Why would you
assign an address to the loopback adapter if you wanted it to be accessed
from the world?  

Anyways, just wasting my breath by expressing my point of view... have fun

Also, if anybody has a link to something that explains how to do this using
an alternate method, or usage for arp_filter... I'd appreciate it if you
could email me... I've been searching for like 2 hours and I havn't found
anything useful.

	Sam Bingner

-----Original Message-----
From: Roberto Nibali [mailto:ratz@drugphish.ch]
Sent: Thursday, December 05, 2002 12:51 PM
To: Phil Oester
Cc: David S. Miller; Bingner Sam J Contractor PACAF CSS/SCHE;
'ja@ssi.bg'; 'linux-kernel@vger.kernel.org'
Subject: Re: hidden interface (ARP) 2.4.20


Hello,

First I would like to ask people not to post such patches to lkml but 
rather to the LVS list, because this affects only LVS so far and we 
cover all kernel versions pretty much up to date. Julian just needs to 
do the s/__constant_htons/htons/ fixes and upload the changes to his site ;)

The inclusion of the hidden feature has been discussed almost to death 
on netdev (where these questions should have gone in the first place) 
and it was decided against inclusion of this patch for various reasons.

Phil Oester wrote:
> So we should enable netfilter for all x-hundred webservers we have?  Or
play games with routing tables?

Yes. What is the problem? You need to setup the x-hundred webservers 
anyway, 2 routing entry lines certainly won't hurt. Yes, I understand 
that if you're in process of upgrading your webservers from 2.2.x to 
2.4.x this is a bit of an additional pain. There are also other 
solutions to this arp problem, but please address this on the LVS 
mailinglist.

> Why was something which:
> 
> a) works
> b) was present in 2.2.xx kernels
> c) is trivial to include and doesn't seem to 'hurt' anything
> 
> ripped from 2.4 kernels?

http://marc.theaimsgroup.com/?t=95743539800002&r=1&w=2

> What some people fail to grasp is that _many_ people in the real world are
using 
 > the hidden flag in load balancing scenarios for its simplicity.
 > Removing it (without any particularly valid reason that anyone is
 > aware of) doesn't make much sense.

Depends if it was a hack before that shouldn't have been there in the 
first place. In an evolutionary process things get optimized ... as has 
happened with the network stack code.

> -Phil
> 
> p.s. flame away, Dave

Search the LVS and the netdev archives for constructive discussions 
about it. No need to flame anyone. But hey, if people keep coming up 
with this, DaveM and Alexey might get weak and put it back in 2.5.x :)

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc
