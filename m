Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbRFBWTG>; Sat, 2 Jun 2001 18:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbRFBWS5>; Sat, 2 Jun 2001 18:18:57 -0400
Received: from pat.uio.no ([129.240.130.16]:36744 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261840AbRFBWSo>;
	Sat, 2 Jun 2001 18:18:44 -0400
MIME-Version: 1.0
Message-ID: <15129.25972.433708.994343@charged.uio.no>
Date: Sun, 3 Jun 2001 00:15:16 +0200
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [newbie] NFS client: port-unreachable
In-Reply-To: <Pine.LNX.4.31.0106022258210.17342-100000@pc40.e18.physik.tu-muenchen.de>
In-Reply-To: <shsd78o2h84.fsf@charged.uio.no>
	<Pine.LNX.4.31.0106022258210.17342-100000@pc40.e18.physik.tu-muenchen.de>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de> writes:

     > No, I have no port specific rules in the firewall (iptables),
     > but this machine does SNAT for 32 other linux boxes which also
     > get some directories from the same server (including YP). I had
     > some trouble with the YPSERV-calls until I bound two more IPs
     > to the network card and masqueraded the 32 boxes via these
     > additional addresses. What might happen is that the specific
     > port gets allocated by some port remapping in iptables during
     > the request, but I don't see why this should happen only for
     > specific directories (e.g. /home works and /compass doesn't
     > while both are from the same server).

Are /home and /compass on the same mount point on the client though? 
If not, then they won't share the same port.

IOW: they will only share the same port if you have '/' as the NFS
mountpoint.

Cheers,
  Trond
