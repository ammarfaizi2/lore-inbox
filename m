Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSIMDOP>; Thu, 12 Sep 2002 23:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSIMDOP>; Thu, 12 Sep 2002 23:14:15 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:43681 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S318159AbSIMDOO> convert rfc822-to-8bit; Thu, 12 Sep 2002 23:14:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>
Subject: Re: [PATCH] ebtables - Ethernet bridge tables, for 2.5.34
Date: Fri, 13 Sep 2002 05:20:41 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <20020911223252.GA12517@erik.ca> <200209120836.52062.bart.de.schuymer@pandora.be> <20020912.160411.66846285.davem@redhat.com>
In-Reply-To: <20020912.160411.66846285.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209130520.41862.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David, Lennert, list,

>    ARP filtering
>
> People should use ARP tables for arp filtering, that is why I wrote
> it.  ARP filtering should not need to be bridge specific.

Well, a bridge can also just _bridge_ ARP packets between two sides of the 
bridge. The ARP module can filter out those packets. These packets will not 
pass through the ARP code of the Linux kernel. Ofcourse, the ebtables ARP 
module can be easily adjusted for arptables, I will do this later if nobody 
beats me to it... For the same reason, basic ebtables IP filtering is not 
redundant.

> Next, has Lennert Buytenhek, the bridging maintainer, approved of your
> changes to the bridging layer APIs?

OK. This is to Lennert:
Could you please have a look at the ebtables patch located at

http://users.pandora.be/bart.de.schuymer/ebtables/v2.0/ebtables-v2.0_vs_2.5.34.diff

and approve the changes made to the bridging layer API? They are necessary to 
make a brouter and to deal with bogus NETFILTER_DEBUG warnings if the option 
is compiled in the kernel. Any questions will be gladly answered... Note that 
the brouting facility has been working for atleast three months and it has 
already been used in real-life situations, there's an example usage on the 
ebtables homepage. Dealing with NETFILTER_DEBUG warnings consists of setting 
nf_debug to zero when the netfilter hooks change from bridge hooks to some 
other stack's hooks and vice versa. See the patch.

-- 
cheers,
Bart

