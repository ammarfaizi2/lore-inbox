Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267363AbSLESxW>; Thu, 5 Dec 2002 13:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbSLESxW>; Thu, 5 Dec 2002 13:53:22 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:12039 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267363AbSLESxV>; Thu, 5 Dec 2002 13:53:21 -0500
Date: Thu, 5 Dec 2002 20:00:54 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [OT] ipv4: how to choose src ip?
Message-ID: <20021205190054.GE23877@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I apologize for a vigorously off-topic post;  Google groups just ain't
helping me this time.

Suppose I have two IP addresses from the same subnet on the same
interface, and this interface also happens to be what my default
gateway is on, like so:

/sbin/ifconfig eth1   213.168.178.209 netmask 255.255.255.192 \
					broadcast 213.168.178.255
/sbin/ifconfig eth1:0 213.168.178.210 netmask 255.255.255.192 \
					broadcast 213.168.178.255
/sbin/route add default gw 213.168.178.193

The question is, how does the IP stack decide what source IP address
it should use when there's a packet to be sent on the given subnet or
via the defaultgw?  Is there any way to actually choose the source IP
address manually (say, per outgoing connection)?

I'm not interested in rewriting the source address with netfilter based
on destination and/or service;  What I'm looking for is rather a way to
initiate two connections to the same destination host using the two
different source IP addresses.

--
Tomas Szepe <szepe@pinerecords.com>
