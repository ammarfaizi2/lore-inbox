Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132753AbRC2PqC>; Thu, 29 Mar 2001 10:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132755AbRC2Ppw>; Thu, 29 Mar 2001 10:45:52 -0500
Received: from [32.97.166.32] ([32.97.166.32]:56232 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S132753AbRC2Ppf>;
	Thu, 29 Mar 2001 10:45:35 -0500
Message-Id: <m14gkoB-001PKiC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Michel Wilson" <mwilson@dds.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast and IP-conntrack problem 
In-Reply-To: Your message of "Thu, 22 Mar 2001 23:36:02 BST."
             <NEBBLEJBILPLHPBNEEHIEEMCCAAA.mwilson@dds.nl> 
Date: Sat, 24 Mar 2001 20:58:07 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <NEBBLEJBILPLHPBNEEHIEEMCCAAA.mwilson@dds.nl> you write:
> Hi!
> 
> I'm having some problems with ip-connection tracking and multicast packets:
> the conntrack stuff doesn't seem to be able to handle multicast packets,
> flooding my logs with messages like these:
> 
> Feb 28 15:53:00 procyon kernel: NAT: 0 dropping untracked packet c7105b00 1
> 195.38.203.147 -> 224.0.0.2

Yes.  Connection tracking doesn't handle multicast.  NAT drops packets
not handled by connection tracking.

Making connection tracking handle multicast is a minor project in itself.

Rusty.
--
Premature optmztion is rt of all evl. --DK
