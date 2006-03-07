Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWCGGCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWCGGCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWCGGCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:02:24 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55981
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751290AbWCGGCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:02:23 -0500
Date: Mon, 06 Mar 2006 22:02:37 -0800 (PST)
Message-Id: <20060306.220237.07925602.davem@davemloft.net>
To: psusi@cfl.rr.com
Cc: bcrl@kvack.org, drepper@gmail.com, da-x@monatomic.org,
       linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <440D06E9.1020901@cfl.rr.com>
References: <440CE336.3080504@cfl.rr.com>
	<20060306.190428.23731173.davem@davemloft.net>
	<440D06E9.1020901@cfl.rr.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phillip Susi <psusi@cfl.rr.com>
Date: Mon, 06 Mar 2006 23:07:05 -0500

> How is this any different from what we have now, other than bypassing 
> the kernel buffer?  The tcp/ip layer looks at the incoming packet to 
> decide what socket it goes with, and copies it to the waiting buffer. 
> Right now that waiting buffer is a kernel buffer, because at the time 
> the packet arrives, the kernel does not have any user buffers.

The whole idea is to figure out what socket gets the packet
without going through the IP and TCP stack at all, in the
hardware interrupt handler, using a tiny classifier that's
very fast and can be implemented in hardware.

Please wrap your brain around the idea a little longer than
the 15 or so minutes you have thus far... thanks.

> Yes, we can and should have a 6 times speed up, but as I've explained 
> above, NT has had that for 10 years without having to push TCP into user 
> space.

That's complete BS.
