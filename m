Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135181AbRECUYN>; Thu, 3 May 2001 16:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135198AbRECUYD>; Thu, 3 May 2001 16:24:03 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:36307 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S135181AbRECUXy>; Thu, 3 May 2001 16:23:54 -0400
Date: Thu, 3 May 2001 15:23:37 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105032023.PAA74826@tomcat.admin.navo.hpc.mil>
To: Venkateshr@ami.com, "'Jesse Pollard'" <pollard@tomcat.admin.navo.hpc.mil>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Alan Cox'"@tomcat.admin.navo.hpc.mil, <alan@lxorguk.ukuu.org.uk>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Subject: RE: [RFC] Direct Sockets Support??
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> 
> 	> Doesn't this bypass all of the network security controls? Granted
> - it is
> 	> completely reasonable in a dedicated environment, but I would
> think the
> 	> security loss would prevent it from being used for most usage.
> 
> 	Direct Sockets makes sense only in clustering (server farms) to
> reduce intra-farm communication. It is *not* supposed to be used for regular
> internet. Direct Sockets over subnets is also tough to implement it across
> different topology subnets. Fabrics like Infiniband provide security on
> hardware, so there is no need to worry about it. The simple point  is that
> hw supports TCP/IP, then why do we need a software TCP/IP over it?

Because the hardware doesn't have the users security context. All it can
see are addresses, socket numbers and protocol. Neither can it be extended
with that information (IPSec). Authentication of the connections are not
possible.

Now... If the server farm only runs one job at a time, it is irrelevent...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
