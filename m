Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266420AbUBQS25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 13:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266428AbUBQS25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 13:28:57 -0500
Received: from dp.samba.org ([66.70.73.150]:2253 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266420AbUBQS2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 13:28:55 -0500
Date: Wed, 18 Feb 2004 05:26:46 +1100
From: Anton Blanchard <anton@samba.org>
To: Paul Blazejowski <paulb@blazebox.homeip.net>, scott.feldman@intel.com
Cc: steve@saturn5.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: e1000 problems in 2.6.x
Message-ID: <20040217182645.GA22534@krispykreme>
References: <1076905069.4092.4.camel@blaze.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076905069.4092.4.camel@blaze.homeip.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> I am experiencing same problem with e1000 on 2.6.3-rc2-mm1 and all
> previous 2.6 kernels with getting the transmit timed out messages.I do
> not get the transmission errors though.The same setup works fine on 2.4
> kernel just like yours.

We beat a recent 2.6 up with specweb on ppc64 and got the transmit
timeout errors within about 30 seconds. Disabling TSO made the problem
go away. (I actually hacked the driver forgetting we can do it via
ethtool these days).

Scott: it smells like the TSO early write back issue, perhaps the new
version of the fix isnt working properly. I need to verify that turning
TSO on/off via ethtool has the same effect.

Anton
