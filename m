Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319194AbSIFQRb>; Fri, 6 Sep 2002 12:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319229AbSIFQRb>; Fri, 6 Sep 2002 12:17:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37375 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319194AbSIFQR3>;
	Fri, 6 Sep 2002 12:17:29 -0400
Message-ID: <1031329283.3d78d603ba4c3@imap.linux.ibm.com>
Date: Fri,  6 Sep 2002 09:21:23 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <20020905.235159.128049953.davem@redhat.com> <46202575.1031297360@[10.10.2.3]> <3D78CBF6.10609@us.ibm.com>
In-Reply-To: <3D78CBF6.10609@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Hansen <haveblue@us.ibm.com>:

> No, no.  Bad Martin!  Throughput didn't drop, "Specweb compliance"
> dropped. Those are two very, very different things.  I've found that
> the server can produce a lot more throughput, although it doesn't
> have the characteristics that Specweb considers compliant.  
> Just have Troy enable mod-status and look at the throughput that
> Apache tells you that it is giving during a run.  
> _That_ is real throughput, not number of compliant connections.

> _And_ NAPI is for receive only, right?  Also, my compliance drop
> occurs with the NAPI checkbox disabled.  There is something else in
> the new driver that causes our problems.

Thanks, Dave, you saved me a bunch of typing...

Just looking at a networking benchmark result is worse than
useless. You really need to look at the stats, settings,
and the profiles. eg, for most of the networking stuff:

ifconfig -a 
netstat -s
netstat -rn
/proc/sys/net/ipv4/
/proc/sys/net/core/

before and after the run. 

Dave, although in your setup the clients are maxed out,
not sure thats the case for Mala and Troy's clients. (Dont
know, of course). But I'm fairly sure they arent using
single quad NUMAs and they may not be seeing the same
effects..

thanks,
Nivedita

