Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262642AbTCPJyt>; Sun, 16 Mar 2003 04:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262639AbTCPJyt>; Sun, 16 Mar 2003 04:54:49 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:51864 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S262637AbTCPJys>; Sun, 16 Mar 2003 04:54:48 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Fowler <cfowler@outpostsentinel.com>,
       Robert White <rwhite@casabyte.com>, Ed Vance <EdV@macrolink.com>,
       "'Linux PPP'" <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1047776160.1327.0.camel@irongate.swansea.linux.org.uk>
References: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com>
	 <1047598241.5292.2.camel@hp.outpostsentinel.com>
	 <1047732394.20703.10.camel@imladris.demon.co.uk>
	 <1047776160.1327.0.camel@irongate.swansea.linux.org.uk>
Message-Id: <1047809131.22070.33.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (dwmw2) (Preview Release)
Date: 16 Mar 2003 10:05:31 +0000
Subject: RE: RS485 communication
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-16 at 00:56, Alan Cox wrote:
> RS485 supports CDMA, thats more than enough to implement ppp nicely, all
> you have to do is a little abuse in the app or driver layer to block
> sending when carrier is asserted

Note you don't need any separate lines for this. If someone else is
transmitting a zero while you are also transmitting a zero, that's fine
and you didn't stomp on each other. If someone else is transmitting a
zero while you are transmitting a one, you won and a one was
transmitted, and they back off. If they transmit a one while you
transmit a zero, then they won :)

That's how CAN does it, IIRC. I don't believe it actually requires
synchronous clocks.

-- 
dwmw2


