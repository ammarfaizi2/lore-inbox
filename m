Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133097AbRECUOV>; Thu, 3 May 2001 16:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135174AbRECUOK>; Thu, 3 May 2001 16:14:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5129 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133097AbRECUOA>; Thu, 3 May 2001 16:14:00 -0400
Subject: Re: [RFC] Direct Sockets Support??
To: Venkateshr@ami.com (Venkatesh Ramamurthy)
Date: Thu, 3 May 2001 21:17:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'),
        Venkateshr@ami.com (Venkatesh Ramamurthy),
        linux-kernel@vger.kernel.org
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9DECA@ATL_MS1> from "Venkatesh Ramamurthy" at May 03, 2001 02:59:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vPXz-00069P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> technology is Infiniband . In Infiniband, the hardware supports IPv6 . For
> this type of devices there is no need for software TCP/IP. But for
> networking application, which mostly uses sockets, there is a performance
> penalty with using software TCP/IP over this hardware. 

IPv6 is only the bottom layer of the stack. TCP does a lot lot more.

> > access setup is actually needed.
> > 
> 	My point is that if the hardware is capable of doing TCP/IP , we
> should let the sockets layer talk directly to it (direct sockets). Thereby
> the application which uses the sockets will get better performance.

That depends on where your overheads are. Remember that for every direct
access you make you trade off kernel syscall overhead against userspace
scheduling and locking overhead. 

The VI architecture tries to design well to handle this I've not seen enough
about infiniband to know that. The 'better performance' is an assumption that
isnt always as simple as it seems - especially with high mtu values and
real world applications

