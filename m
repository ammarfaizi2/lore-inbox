Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbRECTYM>; Thu, 3 May 2001 15:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132859AbRECTYD>; Thu, 3 May 2001 15:24:03 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:13523 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132686AbRECTXy>; Thu, 3 May 2001 15:23:54 -0400
Date: Thu, 3 May 2001 14:23:25 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105031923.OAA68942@tomcat.admin.navo.hpc.mil>
To: Venkateshr@ami.com, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Subject: RE: [RFC] Direct Sockets Support??
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	> Define 'direct sockets' firstly.
> 	Direct Sockets is the ablity by which the application(using sockets)
> can use the hardwares features to provide connection, flow control,
> etc.,instead of the TCP and IP software module. A typical hardware
> technology is Infiniband . In Infiniband, the hardware supports IPv6 . For
> this type of devices there is no need for software TCP/IP. But for
> networking application, which mostly uses sockets, there is a performance
> penalty with using software TCP/IP over this hardware. 
> 
> > I have seen several lines of attack on very high bandwidth devices.
> > Firstly
> > the linux projects a while ago doing usermode message passing directly
> > over
> > network cards for ultra low latency. Secondly there was a VI based project
> > that was mostly driven from userspace.
> > 
> 	The application needs to rewritten to use VIPL, but if we could
> provide a sockets over VI (or Sockets over IB), then the existing
> applications can run with a known environment. 
> 
> 
> > One thing that remains unresolved is the question as to whether the very
> > low
> > cost Linux syscalls and zero copy are enough to achieve this using a
> > conventional socket API and the kernel space, or whether a hybrid direct 
> > access setup is actually needed.
> > 
> 	My point is that if the hardware is capable of doing TCP/IP , we
> should let the sockets layer talk directly to it (direct sockets). Thereby
> the application which uses the sockets will get better performance.

Doesn't this bypass all of the network security controls? Granted - it is
completely reasonable in a dedicated environment, but I would think the
security loss would prevent it from being used for most usage.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
