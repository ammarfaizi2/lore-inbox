Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269377AbUICIRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269377AbUICIRq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUICIPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:15:07 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:63999 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S269368AbUICIHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:07:36 -0400
From: Einar Lueck <elueck@de.ibm.com>
Reply-To: lkml@einar-lueck.de
Organization: IBM Deutschland Entwicklung GmbH
To: Paul Jakma <paul@clubi.ie>
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Date: Fri, 3 Sep 2004 10:07:29 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409011441.10154.elueck@de.ibm.com> <200409021858.38338.elueck@de.ibm.com> <Pine.LNX.4.61.0409022147220.23011@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0409022147220.23011@fogarty.jakma.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409031007.29467.elueck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 2. September 2004 22:59 Paul Jakma wrote:
> 
> I dont see why it wouldnt work, it almost undoubtedly will work for 
> NFS over TCP. And any problems to cause it to not work would be best 
> taking up on the linux-nfs list in order to have a "bind to address" 
> option added to knfsd.

I just set up the loopback interface via ZEBRA/OSPF as You described it 
and checked via tcpdump the source IP address of the related NFS packets.
The kernel chooses the IP address of the NIC he routes the packets over as
the source IP address and not the Source VIPA configured for loopback.  

You are right, it would be one option to have a "bind to address" in KNFSD.
But our idea was to implement a feature well known from other operating 
systems like AIX to Linux because this feature is quite popular and liked 
especially by large customers.  As You have read for sure such a feature
adding redundant functionality to the kernel is not desired. So maybe we
should continue our discussion privately. Thanks for Your suggestions!

> 
> Why could it not be solved? And why is the answer not "ask the knfsd 
> people to provide bind-to-ip option"?
> 

We would win a facility allowing for a Source VIPA for all
kinds of servers not offering an explicit bind option. So: Due to the 
feature port idea mentioned above.

> But on a server, the packets that go out tend to be replies to 
> requests. Or at least, the only packets of interest are replies. It's 
> a rare server that just off its own bat goes and talks to clients 
> which have not communicated first with the server before.

The enterprise customers we care about have for example servers
that utilize other servers (application servers utilizing a database or
a NFS server, etc.). So to generate replies these servers need
replies of other servers .

> 
> Anyway, even if the server for some reason initiated traffic, the 
> correct answer surely is "modify the server to bind to a specific 
> address", no?

As mentioned above ;)

> 
> > Bonding offers a failover facility. For more details, please refer to:
> > Documentation/networking/bonding.txt in the kernel tree.
> 
> Right, but what does bonding (layer 2) have to do with virtual IPs 
> and IP source address?
> 

If we focus for a moment just on the NIC-fail-over issue (not caring 
about layers, virtual IPs, etc.) then bonding offers the desired failover with
some restriction. This is the reason why I mentioned it in this context.

Again, thanks for Your suggestions and maybe we should continue our 
discussion privately.

Regards

Einar.
