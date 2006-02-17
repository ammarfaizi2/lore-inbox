Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWBQIRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWBQIRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 03:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWBQIRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 03:17:52 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:55211 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932586AbWBQIRw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 03:17:52 -0500
Message-ID: <56682.128.237.252.29.1140164271.squirrel@128.237.252.29>
Date: Fri, 17 Feb 2006 03:17:51 -0500 (EST)
Subject: host_driver: Unknown symbol tcp_protocol
From: "George P Nychis" <gnychis@cmu.edu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to compile a module that uses:
extern struct net_protocol tcp_protocol;  /* The TCP protocol already defined */

when I compile it, it gives me the warning:
*** Warning: "tcp_protocol" [/home/hedpe/host_driver.ko] undefined!

so when I try to load it anyways, dmesg of course gives me:
host_driver: Unknown symbol tcp_protocol

So of course I searched a little deeper and found the structure defined in /usr/src/linux/net/ipv4/af_inet.c (2.6.15-r1)

Can anyone provide me some insight on this, if I am maybe missing support in my kernel?  I will paste some of my kernel settings below.  Please CC me when responding so that the mail goes directly to me. 

Thank you!
George

monster linux # grep "NET" /usr/src/linux/.config
CONFIG_NET=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_IP_NF_NETBIOS_NS is not set
CONFIG_IP_NF_TARGET_NETMAP=y
# CONFIG_DECNET is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_NET_SCHED is not set
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y
# CONFIG_NET_SB1000 is not set
# CONFIG_ARCNET is not set
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_TULIP is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_NET_POCKET is not set
CONFIG_NET_RADIO=y
CONFIG_NET_WIRELESS=y
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_USB_USBNET is not set

