Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSIZRF2>; Thu, 26 Sep 2002 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261381AbSIZRF2>; Thu, 26 Sep 2002 13:05:28 -0400
Received: from sopris.net ([216.237.72.68]:19728 "EHLO mail.sopris.net")
	by vger.kernel.org with ESMTP id <S261376AbSIZRF0>;
	Thu, 26 Sep 2002 13:05:26 -0400
Message-ID: <004201c2657f$c1a1bed0$f101010a@nathan>
From: "Nathan" <etherwolf@sopris.net>
To: "Marc-Christian Petersen" <m.c.p@wolk-project.de>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
References: <200209261901.17679.m.c.p@wolk-project.de>
Subject: Re: Updated to kernel 2.4.19 and now ipchains and iptables are broke.
Date: Thu, 26 Sep 2002 11:11:29 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw the config option for netfilter that said if you use this it won't use
ipchains, so I said no to that...

The section of my .config file from make config (yeah I'm a glutton for
punishment):

# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE=y
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
CONFIG_IPV6=y
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set



----- Original Message -----
From: "Marc-Christian Petersen" <m.c.p@wolk-project.de>
To: <linux-kernel@vger.kernel.org>
Cc: "Nathan" <etherwolf@sopris.net>
Sent: Thursday, September 26, 2002 11:02 AM
Subject: Re: Updated to kernel 2.4.19 and now ipchains and iptables are
broke.


Hi Nathan,

> This is surely the greenest of green questions (sorry), but I finally got
my
> kernel re-compiled the way I want it using the 2.4.19 sources from
> kernel.org. It loads, seems to be working fine, except ipchains and
> iptables... ipchains insists that it is incompatible with my kernel, and
> iptables isn't sure what's going on but it thinks maybe something (. Well
> fine. I downloaded the latest versions of ipchains/tables from rpmfind and
> upgraded, same thing.

"Incompatible with this kernel" for ipchains seems so that you have compiled
Netfilter stuff into your kernel.

"itself or the kernel needs upgrading" for iptables seems so that you either
haven't compiled netfilter as module(s) or static into the kernel and forgot
something in the kernel config.

> I haven't been able to find any actual solutions off google for this... a
> few people mention the same problem but no fixes. Can someone point this
> rookie in the right direction to fix my packet filters? :-)
Check your kernel config. "make menuconfig" or "xconfig" and goto:

Networking options  --->
  IP: Netfilter Configuration  --->

and look if you did it properly.

--
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.

