Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266609AbUHIO2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUHIO2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUHIO1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:27:11 -0400
Received: from 213-0-210-149.dialup.nuria.telefonica-data.net ([213.0.210.149]:9352
	"EHLO localhost") by vger.kernel.org with ESMTP id S266609AbUHIOZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:25:56 -0400
Date: Mon, 9 Aug 2004 16:25:55 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Disabling route cache
Message-ID: <20040809142555.GC4917@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <000701c47d75$7f529260$8001a8c0@CPQ31353534830>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c47d75$7f529260$8001a8c0@CPQ31353534830>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 09 August 2004, at 02:28:18 +0800,
ken wrote:

> I am building Linux routers with multiple DSL WAN links. I'm using
> iproute2 to load balance users onto the Internet. However, with IP route
> cache the result is sometimes poor. Is there a way to disable route
> caching in the kernel.
> 
If the problem is that after a link/ISP failure some already stablished
connections or new connections use the cached route to go through the
failed link, you can make the kernel forget about any route caches it
currently has with the command:
# ip route flush cache

You can check the routing cache at any time with:
# ip route show cache

Hope it helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.8-rc2-mm2)
