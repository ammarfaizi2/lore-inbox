Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268293AbTBMVDR>; Thu, 13 Feb 2003 16:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268294AbTBMVDQ>; Thu, 13 Feb 2003 16:03:16 -0500
Received: from mons.uio.no ([129.240.130.14]:19939 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S268293AbTBMVDN>;
	Thu, 13 Feb 2003 16:03:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15948.2650.639700.363495@charged.uio.no>
Date: Thu, 13 Feb 2003 22:12:58 +0100
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 NFS FSX
In-Reply-To: <20030213204906.GA24109@codemonkey.org.uk>
References: <20030213152742.GA1560@codemonkey.org.uk>
	<20030213185410.GN20972@ca-server1.us.oracle.com>
	<shsd6lwati2.fsf@charged.uio.no>
	<20030213204906.GA24109@codemonkey.org.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@codemonkey.org.uk> writes:

     > A tcpdump capture is at .....

     > There seems to be some garbage at the end of the capture.  I'm
     > not sure why, but it seems tcpdump does that sometimes.

Does it do that on 2.4.x? I've certainly never seen that happen on a
stable kernel.

In fact ethereal reports 

 Message: pcap: File has 1045168887-byte packet, bigger than maximum of 65535

No wonder we see bizarre crashes...

There are several other odd features in this tcpdump. Random UDP
packets from the server to the client with a junk payload (usually
consisting of a load of zeros) appear to be pretty frequent.

Is this against a 2.5.x server? If so, could you try against a 2.4.x
or a non-linux server?

Cheers,
  Trond

Note: I saw similar problems when I tried to convert the NFS client to
use the new zero-copy UDP interface (and so I dropped the idea).
