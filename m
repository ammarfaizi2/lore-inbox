Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbREHNSL>; Tue, 8 May 2001 09:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132516AbREHNSA>; Tue, 8 May 2001 09:18:00 -0400
Received: from netcore.fi ([193.94.160.1]:4875 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S132503AbREHNRn>;
	Tue, 8 May 2001 09:17:43 -0400
Date: Tue, 8 May 2001 16:17:40 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ipv6 activity causing system hang in kernel 2.4.4 [solution]
Message-ID: <Pine.LNX.4.33.0105081614160.10502-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for breaking the thread, but I only read l-k through www archives,
so...

This problem is fixed in CVS.  Apply:

http://vger.samba.org/cgi-bin/cvsweb/linux/net/ipv6/ndisc.c.diff?r1=1.49&r2=1.50&cvsroot=vger

And you'll be fine.

Please Cc: if follow-ups.

--8<--
In article <871yq3mllw.fsf@straw.pigsty.org.uk> you wrote:

> This is only with kernel 2.4.4; 2.4.2, 2.4.3 and NetBSD boxes are not
> affected. It is independent of platform; I've reproduced it at will on a
> lowly p75, an athlon, a p3-800 and on a powerbook/PPC.

I have just reproduced that on 2.4.5pre-1. It was only one ping (ping6)
(from the other side of ipv6 over ipv4 tunnel.


> All kernels are compiled to have ipv6 modular, netfilter modular...
> everything with which I'm playing, modular.

My configuration is without any ipv6/netfilter modules - all build in
kernel.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords

