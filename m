Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSKMSYG>; Wed, 13 Nov 2002 13:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSKMSYG>; Wed, 13 Nov 2002 13:24:06 -0500
Received: from chaos.analogic.com ([204.178.40.224]:47236 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262248AbSKMSYG>; Wed, 13 Nov 2002 13:24:06 -0500
Date: Wed, 13 Nov 2002 13:33:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chuck Lever <cel@citi.umich.edu>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: [PATCH] new timeout behavior for RPC requests on TCP sockets
In-Reply-To: <1037209348.11996.109.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1021113133009.2518A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 2002, Alan Cox wrote:

> On Wed, 2002-11-13 at 16:44, Richard B. Johnson wrote:
> > If the application "chooses to drop the request", the kernel is not
> > required to fix that application. The RPC cannot retransmit if
> > it has been shut-down or disconnected, which is about the only
> > way the application could "choose to drop the request". So something
> > doesn't smell right here.
> 
> Check your socks...
> 
> As far as RPC goes the RPC server can choose to drop a request whenever
> it pleases by simply throwing it away (eg reading it from the socket and
> binning it) depending on its workload. There are actually reasons for
> that in some situations (eg if the top requests are all for a volume
> that is down its better to throw them away so you can get requests for a
> volume that is functional)
> 
> Alan

Yes! But, the Client it is perfectly free to request it again and
should (must) to keep any mounted volumes intact. This doesn't
affect the internal TCP/IP stack (or it shouldn't). Since the whole
NFS thing is "stateless", the client just issues another request.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


