Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293432AbSCOX5T>; Fri, 15 Mar 2002 18:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293447AbSCOX5J>; Fri, 15 Mar 2002 18:57:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2579 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293432AbSCOX5E>; Fri, 15 Mar 2002 18:57:04 -0500
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
To: davem@redhat.com (David S. Miller)
Date: Sat, 16 Mar 2002 00:12:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, davids@webmaster.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020315.154527.98068496.davem@redhat.com> from "David S. Miller" at Mar 15, 2002 03:45:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16m1oW-00057N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Errors in logic in TCP need to be dealt with by breaking the
> connection and spitting a RST out, and it must be done in a
> way that is as easy to verify as possible.

The two are no different. Someone at cisco stuffed an IP authentication
header in the TCP frame. Its stupid, but the RST argument is not a real one

> IPSEC getting the signature wrong is more akin to getting bitstream
> corruptions from your networking card for a certain sequence of bytes.

Ditto the TCP bad MD5 sum and a tcp checksum error.

I've actually got a more constructive suggestion for the zebra folks. 
Route the BGP crap through a netlink tap device, mangle and unmangle the
tcp frames in luserspace. Saves doing TCP in userspace, saves screwing up
Dave's nice networking stack.

You'll still need to kill SACK support to make it fit

