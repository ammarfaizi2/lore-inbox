Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293550AbSCPAIW>; Fri, 15 Mar 2002 19:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293543AbSCPAHM>; Fri, 15 Mar 2002 19:07:12 -0500
Received: from mail.webmaster.com ([216.152.64.131]:10746 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S293548AbSCPAGb> convert rfc822-to-8bit; Fri, 15 Mar 2002 19:06:31 -0500
From: David Schwartz <davids@webmaster.com>
To: <davem@redhat.com>, <alan@lxorguk.ukuu.org.uk>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Fri, 15 Mar 2002 16:06:27 -0800
In-Reply-To: <20020315.155748.68123299.davem@redhat.com>
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020316000629.AAA989@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Mar 2002 15:57:48 -0800 (PST), David S. Miller wrote:
>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>Date: Sat, 16 Mar 2002 00:12:48 +0000 (GMT)
>
>I've actually got a more constructive suggestion for the zebra folks.
>Route the BGP crap through a netlink tap device, mangle and unmangle the
>tcp frames in luserspace. Saves doing TCP in userspace, saves screwing up
>Dave's nice networking stack.
>
>You'll still need to kill SACK support to make it fit
>
>Another solution could involve a netfilter module to mangle
>the packets.

	The problem is that this is intended to be used on machines that are routing 
very high volumes of packets on multiple FEs. So the implementation would 
have to be minimal cost for packets it didn't need to intercept. So I'd need 
to hook into a kernel module or userspace through a filter.

	Does ipchains/iptables support to filter selected packets through userspace 
work? If it does, this might be an acceptable solution.

	DS


