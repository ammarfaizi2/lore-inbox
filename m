Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288838AbSAEPV3>; Sat, 5 Jan 2002 10:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288843AbSAEPVR>; Sat, 5 Jan 2002 10:21:17 -0500
Received: from cs182172.pp.htv.fi ([213.243.182.172]:5253 "EHLO
	cs182172.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S288838AbSAEPVK>; Sat, 5 Jan 2002 10:21:10 -0500
Message-ID: <3C3719D1.F3B214B6@welho.com>
Date: Sat, 05 Jan 2002 17:20:49 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to debug very strange packet delivery problem?
In-Reply-To: <005001c194d9$b5793c40$6caaa8c0@kevin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kevin P. Fleming" wrote:
> The machine runs fine, and other nodes on the local network (i.e. using the
> ethernet interface) can communicate with it just fine. I can also bring up
> the ppp link, and communicate with everything on the corporate WAN without
> trouble. I can communicate _through_ this machine from nodes on the local
> network to the corporate WAN just fine. But...
> 
> What I _cannnot_ do is initiate a connection from a node on the other side
> of the ppp link (the corporate side) to this machine. There are at least
> three daemon processes on this system I've tried to connect to: xinetd (for
> telnet), bind and exim. None of these are using tcp_wrappers. The symptoms
> are that the TCP SYN packet (to open the connection) arrives at the ppp0
> interface (verified by using tcpdump on the ppp0 interface), but then is not
> delivered to the waiting process on its open socket.

Hi Kevin,

You seem to know what you're doing there, but it would still help if you
could provide some details of your routing configuration and servers,
e.g. output of ifconfig, route -n, and netstat -anot, iptables -L
(provided that the company security policy allows you to share this
info, of course :-). Are you doing NAT between the local net and the
corporate WAN or are you sharing a subnet? Are you sure that it's the
SYN getting lost rather than the SYN-ACK from the server? Even though
your machine is forwarding fine it might still be a routing problem of
some kind.

Cheers,

	MikaL
