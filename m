Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbULCJIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbULCJIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbULCJIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:08:20 -0500
Received: from alephnull.demon.nl ([212.238.201.82]:18371 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S262102AbULCJHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:07:33 -0500
Date: Fri, 3 Dec 2004 10:07:32 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Zoltan NAGY <nagyz@nefty.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPv6 bridging
Message-ID: <20041203090731.GB3964@xi.wantstofly.org>
References: <41AF57D7.10608@nefty.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AF57D7.10608@nefty.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 06:58:47PM +0100, Zoltan NAGY wrote:

> Hello!

Hello!


> Is it possible to bridge ip tunnels (IPv6 in IPv4)? brctl gives me an 
> error "Invalid argument",
> and from strace it seems it misses some ioctls from kernel...

Uhm.  The only things you can bridge together are ethernet devices.
An IP tunnel is not an ethernet device, is it?  This requirement is
there because the bridge just fowards ethernet frames, and knows
nothing about doing neighbour resolution (ARP) to get the right MAC
address, etc.

You might want to fiddle something with proxy ARP.


--L
