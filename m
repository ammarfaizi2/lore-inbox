Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSHYOfe>; Sun, 25 Aug 2002 10:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSHYOfe>; Sun, 25 Aug 2002 10:35:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35574 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317385AbSHYOfe>; Sun, 25 Aug 2002 10:35:34 -0400
Subject: Re: packet re-ordering on SMP machines.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D6884BC.5090004@candelatech.com>
References: <3D6884BC.5090004@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 25 Aug 2002 15:41:13 +0100
Message-Id: <1030286473.16651.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-25 at 08:18, Ben Greear wrote:
> By re-ordered, I mean that a method called from process_backlog in dev.c
> is being handed packets in a different order than they are being poked into
> the driver with hard_start_xmit on the other interface.  If each CPU can be running the
> process_backlog, then I can see how this could be happening.
> 
> 
> 1)  Is this expected behaviour?
Yes

> 2)  Is there any standard (ie configurable) way to enforce strict ordering on an
>      SMP system?
No

> 3)  If answer to 2 is no, would you all be interested in a patch that
>      did allow strict ordering (if indeed I can figure out how to write one)?

You should never need it. Ethernet, hubs, switches, routers, internet
backbones etc will all cause packet re-ordering. You should also expect
the percentage of re-ordered frames on the net to rise and rise. 


