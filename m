Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUAXWFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUAXWFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:05:42 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:45440 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S261779AbUAXWFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:05:38 -0500
Date: Sat, 24 Jan 2004 23:05:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] [2.4] forcedeth network driver
Message-ID: <20040124220545.GA3246@ucw.cz>
References: <4012BF44.9@colorfullife.com> <4012D3C6.1050805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4012D3C6.1050805@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 03:21:26PM -0500, Jeff Garzik wrote:
> >>>+static int alloc_rx(struct net_device *dev)
> >>>+{
> >[snip]
> >>>+    return 0;
> >>>+}
> >>
> >>skb_reserve() seems to be missing
> >>
> >Do you have specs that show that all nForce versions support unaligned 
> >buffers? skb_reserve is a performance feature, I don't want to add it 
> >yet. Testing that it works is on our TODO list.
> 
> hmmmm, is nForce ever found on non-x86 boxes?  I would think that 
> skb_reserve might be -required- for some platforms.

AMD64 and PPC64 as far as I know. But you may consider the first one
still a x86 box.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
