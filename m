Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268305AbTBMVZN>; Thu, 13 Feb 2003 16:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268306AbTBMVZM>; Thu, 13 Feb 2003 16:25:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:57758 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268305AbTBMVZL>;
	Thu, 13 Feb 2003 16:25:11 -0500
Date: Thu, 13 Feb 2003 21:30:48 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 NFS FSX
Message-ID: <20030213213048.GA24878@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030213152742.GA1560@codemonkey.org.uk> <20030213185410.GN20972@ca-server1.us.oracle.com> <shsd6lwati2.fsf@charged.uio.no> <20030213204906.GA24109@codemonkey.org.uk> <15948.2650.639700.363495@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15948.2650.639700.363495@charged.uio.no>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 10:12:58PM +0100, Trond Myklebust wrote:

 > > There seems to be some garbage at the end of the capture.  I'm
 > > not sure why, but it seems tcpdump does that sometimes.
 > Does it do that on 2.4.x? I've certainly never seen that happen on a
 > stable kernel.

I'll try in a few minutes. It doesn't always do it in 2.5, just like
once every dozen or so captures.  NIC is a 3com 3c905C-TX/TX-M [Tornado]
in the client, and an Intel 82801BA/BAM/CA/CAM in the server, both
boxes connected through a cheapo 100MB switch. Nothing special.

 > In fact ethereal reports 
 > 
 >  Message: pcap: File has 1045168887-byte packet, bigger than maximum of 65535
 > No wonder we see bizarre crashes...

That did seem odd yes.  I put it down to a tcpdump bug.
But if you think thats whats triggering it...

 > There are several other odd features in this tcpdump. Random UDP
 > packets from the server to the client with a junk payload (usually
 > consisting of a load of zeros) appear to be pretty frequent.

Wacky. Interested netdev parties can find the ~2MB tcpdump output at
http://www.codemonkey.org.uk/cruft/tcp-trond.bz2
(please don't hammer that server with requests for this unless you
 really do want/need it - the mind boggles at how many hits the nfs
 fsx dumps got in the past -- I'm sure we don't have *that* many
 interested NFS developers 8-).

 > Is this against a 2.5.x server? If so, could you try against a 2.4.x
 > or a non-linux server?

This is a 2.4.21pre3 server.  No non-linux servers to try against
right now..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
