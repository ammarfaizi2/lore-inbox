Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRECTE7>; Thu, 3 May 2001 15:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132483AbRECTEs>; Thu, 3 May 2001 15:04:48 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:25355 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S132571AbRECTE3>; Thu, 3 May 2001 15:04:29 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402B9DECA@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [RFC] Direct Sockets Support??
Date: Thu, 3 May 2001 14:59:23 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	> Define 'direct sockets' firstly.
	Direct Sockets is the ablity by which the application(using sockets)
can use the hardwares features to provide connection, flow control,
etc.,instead of the TCP and IP software module. A typical hardware
technology is Infiniband . In Infiniband, the hardware supports IPv6 . For
this type of devices there is no need for software TCP/IP. But for
networking application, which mostly uses sockets, there is a performance
penalty with using software TCP/IP over this hardware. 

> I have seen several lines of attack on very high bandwidth devices.
> Firstly
> the linux projects a while ago doing usermode message passing directly
> over
> network cards for ultra low latency. Secondly there was a VI based project
> that was mostly driven from userspace.
> 
	The application needs to rewritten to use VIPL, but if we could
provide a sockets over VI (or Sockets over IB), then the existing
applications can run with a known environment. 


> One thing that remains unresolved is the question as to whether the very
> low
> cost Linux syscalls and zero copy are enough to achieve this using a
> conventional socket API and the kernel space, or whether a hybrid direct 
> access setup is actually needed.
> 
	My point is that if the hardware is capable of doing TCP/IP , we
should let the sockets layer talk directly to it (direct sockets). Thereby
the application which uses the sockets will get better performance.



