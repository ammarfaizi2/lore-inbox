Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135209AbRECUpt>; Thu, 3 May 2001 16:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135210AbRECUpj>; Thu, 3 May 2001 16:45:39 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:38661 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S135209AbRECUph>; Thu, 3 May 2001 16:45:37 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402B9DECE@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: pollard@tomcat.admin.navo.hpc.mil,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        linux-kernel@vger.kernel.org
Subject: RE: [RFC] Direct Sockets Support??
Date: Thu, 3 May 2001 16:40:31 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For the case where the routing will be external. Thats conveniently
> something
> you can deduce in advance. In theory nothing stops you implementing this.
> Conventionally you would do that with BSD sockets by implementing a new
> socket family PF_INFINIBAND. You might then choose to make the selection
> of that either done by the application or under it by C library overrides.
> 
	Thats exactly my point, we need to define a new protocol family to
support it. This means that all applications using PF_INET needs to be
changed and recompiled. My basic argument goes like this if hardware can
support the notion of connection, the sockets layer should be aware of this
and send all request to the hw. I can assign an IPv4 address(for sake of
backward compatiblity) and get away w/o software TCP/IP.i get the
performance benefit of hardware TCP/IP (notion of connection). 

	The windoze 2000 DDK has an interesting section about WinSock
direct(r) that lets the SAN hardware (like IB) to still use traditional
PF_INET for it.

	Also one interesting whitepaper 
	
http://servernet.himalaya.compaq.com/snet2/whitepapers/WSD_Perf_White_Paper_
3-21-01.doc


