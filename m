Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAVK1E>; Mon, 22 Jan 2001 05:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbRAVK0y>; Mon, 22 Jan 2001 05:26:54 -0500
Received: from [213.221.172.239] ([213.221.172.239]:4625 "EHLO
	smtp-relay1.barrysworld.com") by vger.kernel.org with ESMTP
	id <S129413AbRAVK0j>; Mon, 22 Jan 2001 05:26:39 -0500
Date: Mon, 22 Jan 2001 10:26:00 +0000
From: Scaramanga <scaramanga@barrysworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Firewall netlink question...
Message-ID: <20010122102600.A4458@lemsip.lan>
Reply-To: scaramanga@barrysworld.com
In-Reply-To: <20010122073343.A3839@lemsip.lan> <Pine.LNX.4.21.0101221045380.25503-100000@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0101221045380.25503-100000@titan.lahn.de>; from pmhahn@titan.lahn.de on Mon, Jan 22, 2001 at 09:46:03 +0000
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> QUEUE means to pass the packet to userspace (if supported by the kernel).

Looking at the code it seemed to do the same thing as the old netlink, but
with more complexity, to what end though, i couldnt tell, was only a brief
skim.

> $ sed -n -e '1874,1876p' /usr/src/linux-2.4.0/Documentation/Configure.help
> CONFIG_IP_NF_QUEUE
>   Netfilter has the ability to queue packets to user space: the
>   netlink device can be used to access them using this driver.
> 
> $ lynx /usr/share/doc/iptables/html/packet-filtering-HOWTO-7.html
> 

Yeah, after some quick googling and freshmeating, i came accross a daemon
that picked up these QUEUEd packets and multiplexed them to various child
processes, which seemed very innefcient, the documentation said something
about QUEUE not being multicast in nature, like the old firewall netlink.

What was wrong with the firewall netlink? My re-implementation works great
here. I can't see why anything else would be needed, QUEUE seems twice as
complex. Unless with QUEUE the userspce applications can make decisions on
what to do with the packet? In which case, it would be far too inefficient
for an application like mine, where all i need is to be able to read the
IP datagrams..

Am I missing something totally obvious?

Regards

--
// Gianni Tedesco <scaramanga@barrysworld.com>
Fingerprint: FECC 237F B895 0379 62C4  B5A9 D83B E2B0 02F3 7A68
Key ID: 02F37A68

egg.microsoft.com: Remote operating system guess: Solaris 2.6 - 2.7

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
