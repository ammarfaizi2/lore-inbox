Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTLBGna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 01:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTLBGna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 01:43:30 -0500
Received: from www.stereoconnection.CA ([216.16.235.58]:33198 "EHLO
	nic.NetDirect.CA") by vger.kernel.org with ESMTP id S261190AbTLBGn3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 01:43:29 -0500
Date: Tue, 2 Dec 2003 01:43:28 -0500
From: Chris Frey <cdfrey@netdirect.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.23] compile / link error in net/ipv4/netfilter
Message-ID: <20031202014328.A10101@netdirect.ca>
References: <20031201202853.A31914@netdirect.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031201202853.A31914@netdirect.ca>; from cdfrey@netdirect.ca on Mon, Dec 01, 2003 at 08:28:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 08:28:53PM -0500, Chris Frey wrote:
> When compiling 2.4.23, it stops during the compile with these errors:
...
> iptable_nat.o(.text+0x2830): first defined here
> ipchains.o(.text+0x77c0): In function `place_in_hashes':
> : multiple definition of `place_in_hashes'

Just posting the answer I found in case someone else needs it.

This was due to turning off Loadable module support after loading a
config in menuconfig that had some modules previously enabled, without
going through and turning them all off before compiling.

- Chris

