Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTESBfJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 21:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTESBfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 21:35:09 -0400
Received: from rth.ninka.net ([216.101.162.244]:24192 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262297AbTESBfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 21:35:08 -0400
Subject: Re: Naming devices
From: "David S. Miller" <davem@redhat.com>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200305181822.51612.dsteklof@us.ibm.com>
References: <20030518213358.GE8994@krispykreme>
	 <200305181822.51612.dsteklof@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053308881.3909.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 May 2003 18:48:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-18 at 18:22, Daniel Stekloff wrote:
> Just last week or so, Jim Keniston asked for comments on network device 
> specific macros - netdev_printk. I thought these were handy when I was 
> working on a system with 4 ethernet cards.

I don't understand how this is useful for this application.
If I put 1,000 e1000 cards into the machine, all the messages
scroll out of the dmesg buffer.

The only reliable source for this kind of information is ethtool.
The kernel message buffer is like IP datagram delivery in that it is
unreliable, whereas ethtool provides a stable source for this
information.

All I hear is that "hey we're making printk provide the same
information as ethtool", and when duplicating functionality you
ought to have a real good reason for it :-)

-- 
David S. Miller <davem@redhat.com>
