Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbRFBVF2>; Sat, 2 Jun 2001 17:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbRFBVFS>; Sat, 2 Jun 2001 17:05:18 -0400
Received: from [129.187.154.153] ([129.187.154.153]:39944 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S261309AbRFBVFI>; Sat, 2 Jun 2001 17:05:08 -0400
Date: Sat, 2 Jun 2001 23:04:33 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [newbie] NFS client: port-unreachable
In-Reply-To: <shsd78o2h84.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.31.0106022258210.17342-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Jun 2001, Trond Myklebust wrote:

>      > (port-unreachable) goes out to the server.  This is annoying
>      > since it blocks all access to that directory.  The request in
>      > question is sent and received at port 772.
>
>      > I'm using kernel 2.4.4.
>
> You probably have set ipchains or ipfilter to block port 772 on your
> client.
No, I have no port specific rules in the firewall (iptables), but this
machine does SNAT for 32 other linux boxes which also get some directories
from the same server (including YP). I had some trouble with the
YPSERV-calls until I bound two more IPs to the network card and
masqueraded the 32 boxes via these additional addresses. What might happen
is that the specific port gets allocated by some port remapping in
iptables during the request, but I don't see why this should happen only
for specific directories (e.g. /home works and /compass doesn't while
both are from the same server).

Ciao,
					Roland

