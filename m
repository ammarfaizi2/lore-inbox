Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264471AbUEDTdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUEDTdC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbUEDTdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:33:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17057 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264471AbUEDTdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:33:00 -0400
Date: Tue, 4 May 2004 16:11:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] tulip driver deadlocks on device removal
Message-ID: <20040504141127.GH1188@openzaurus.ucw.cz>
References: <4096BBC8.60509@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4096BBC8.60509@gmx.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If I remove the card, my machine freezes instantly. This is due to a
> stupid dev->poll function of the tulip driver.
> 
> drivers/net/tulip/interrupt.c:tulip_poll() gets stuck in an endless loop
> in interrupt context if the hardware returns 0xffffffff on certain reads.
> But this is exactly what happens if you remove a pci device.
> 
> My patch replaces the deadlock with something resembling a livelock. At
> least SysRq-S works now because we leave the poll function after some time.

Could you explicitely check for read returning 0xffffffff?

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

