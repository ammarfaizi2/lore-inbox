Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSIFQ0m>; Fri, 6 Sep 2002 12:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318497AbSIFQ0m>; Fri, 6 Sep 2002 12:26:42 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:17919 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318447AbSIFQ0m>; Fri, 6 Sep 2002 12:26:42 -0400
Date: Fri, 06 Sep 2002 09:29:50 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <53430559.1031304588@[10.10.2.3]>
In-Reply-To: <3D78C9BD.5080905@us.ibm.com>
References: <3D78C9BD.5080905@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I thought that I already tried to explain this to you.  (although 
> it could have been on one of those too-much-coffee-days :)

You told me, but I'm far from convinced this is the problem. I think
it's more likely this is a side-effect of a server issue - something
like a lot of dropped packets and retransmits, though not necessarily
that.

> Something strange happens to the clients when NAPI is enabled on 
> the Specweb clients.  Somehow the start using a lot more CPU.  
> The increased idle time on the server is because the _clients_ are 
> CPU maxed.  I have some preliminary oprofile data for the clients, 
> but it appears that this is another case of Specweb code just 
> really sucking.

Hmmm ... if you change something on the server, and all the clients
go wild, I'm suspicious of whatever you did to the server. You need
to have a lot more data before leaping to the conclusion that it's
because the specweb client code is crap.

Troy - I think your UP clients weren't anywhere near maxed out on 
CPU power, right? Can you take a peek at the clients under NAPI load?

Dave - did you ever try running 4 specweb clients bound to each of
the 4 CPUs in an attempt to make the clients scale better? I'm 
suspicious that you're maxing out 4 4-way machines, and Troy's
16 UPs are cruising along just fine.

M.

