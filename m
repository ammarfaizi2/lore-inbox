Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135186AbRECU0Y>; Thu, 3 May 2001 16:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135206AbRECU0O>; Thu, 3 May 2001 16:26:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11017 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135186AbRECU0J>; Thu, 3 May 2001 16:26:09 -0400
Subject: Re: [RFC] Direct Sockets Support??
To: Venkateshr@ami.com (Venkatesh Ramamurthy)
Date: Thu, 3 May 2001 21:29:22 +0100 (BST)
Cc: pollard@tomcat.admin.navo.hpc.mil ('Jesse Pollard'),
        Venkateshr@ami.com (Venkatesh Ramamurthy),
        alan@lxorguk.ukuu.org.uk ('Alan Cox'), linux-kernel@vger.kernel.org
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9DECC@ATL_MS1> from "Venkatesh Ramamurthy" at May 03, 2001 03:25:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vPj3-0006AJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> different topology subnets. Fabrics like Infiniband provide security on
> hardware, so there is no need to worry about it. The simple point  is that
> hw supports TCP/IP, then why do we need a software TCP/IP over it?

For the case where the routing will be external. Thats conveniently something
you can deduce in advance. In theory nothing stops you implementing this.
Conventionally you would do that with BSD sockets by implementing a new
socket family PF_INFINIBAND. You might then choose to make the selection
of that either done by the application or under it by C library overrides.

A network protocol stack is also not required to use sk_buffs, or to use
conventional dev_queue_foo() models so you can write a fairly thin layer.
What I am not sure about would be the best way to implement read/write
operations if the hardware can support these without kernel calls - ie
via mmap and secure page access.

That bit is an interesting problem

Alan



