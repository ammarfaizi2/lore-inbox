Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSKMRKS>; Wed, 13 Nov 2002 12:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSKMRKS>; Wed, 13 Nov 2002 12:10:18 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:16298 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262312AbSKMRKQ>; Wed, 13 Nov 2002 12:10:16 -0500
Subject: re: [PATCH] new timeout behavior for RPC requests on TCP sockets
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Chuck Lever <cel@citi.umich.edu>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021113113943.2196A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021113113943.2196A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 17:42:28 +0000
Message-Id: <1037209348.11996.109.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 16:44, Richard B. Johnson wrote:
> If the application "chooses to drop the request", the kernel is not
> required to fix that application. The RPC cannot retransmit if
> it has been shut-down or disconnected, which is about the only
> way the application could "choose to drop the request". So something
> doesn't smell right here.

Check your socks...

As far as RPC goes the RPC server can choose to drop a request whenever
it pleases by simply throwing it away (eg reading it from the socket and
binning it) depending on its workload. There are actually reasons for
that in some situations (eg if the top requests are all for a volume
that is down its better to throw them away so you can get requests for a
volume that is functional)

Alan

