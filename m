Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbSLEWoN>; Thu, 5 Dec 2002 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267574AbSLEWoN>; Thu, 5 Dec 2002 17:44:13 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:8428 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S267571AbSLEWoM>; Thu, 5 Dec 2002 17:44:12 -0500
Message-ID: <3DEFD845.1000600@drugphish.ch>
Date: Thu, 05 Dec 2002 23:50:45 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phil Oester <kernel@theoesters.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Bingner Sam J Contractor PACAF CSS/SCHE 
	<Sam.Bingner@hickam.af.mil>,
       "'ja@ssi.bg'" <ja@ssi.bg>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil> <1039124530.18881.0.camel@rth.ninka.net> <20021205140349.A5998@ns1.theoesters.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First I would like to ask people not to post such patches to lkml but 
rather to the LVS list, because this affects only LVS so far and we 
cover all kernel versions pretty much up to date. Julian just needs to 
do the s/__constant_htons/htons/ fixes and upload the changes to his site ;)

The inclusion of the hidden feature has been discussed almost to death 
on netdev (where these questions should have gone in the first place) 
and it was decided against inclusion of this patch for various reasons.

Phil Oester wrote:
> So we should enable netfilter for all x-hundred webservers we have?  Or play games with routing tables?

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

> What some people fail to grasp is that _many_ people in the real world are using 
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

