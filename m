Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRAVJty>; Mon, 22 Jan 2001 04:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRAVJto>; Mon, 22 Jan 2001 04:49:44 -0500
Received: from www.lahn.de ([213.61.112.58]:10876 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S130154AbRAVJtd>;
	Mon, 22 Jan 2001 04:49:33 -0500
Date: Mon, 22 Jan 2001 10:46:03 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: pmhahn@titan.lahn.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Firewall netlink question...
In-Reply-To: <20010122073343.A3839@lemsip.lan>
Message-ID: <Pine.LNX.4.21.0101221045380.25503-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001, Scaramanga wrote:

> Under Linux 2.2.x I used to be able to use ipchains to send packet to a
> netlink socket so that my userspace application could further analyze
> the packet data.
> 
> Since kernel 2.4 and iptables, I have not enjoyed the same functionality,
> has it been deprecated in favour of a better method, if so, what? I ask 
> because I just spent my last few hours writing an iptables plugin, and 
> netfilter target kernel module, in order to replace the old functionality 
> exactly, to the end that my application works with zero modifications.
You might take a look at

$ man iptables
...
TARGETS
...
QUEUE means to pass the packet to userspace (if supported by the kernel).

$ sed -n -e '1874,1876p' /usr/src/linux-2.4.0/Documentation/Configure.help
CONFIG_IP_NF_QUEUE
  Netfilter has the ability to queue packets to user space: the
  netlink device can be used to access them using this driver.

$ lynx /usr/share/doc/iptables/html/packet-filtering-HOWTO-7.html

BYtE   
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
