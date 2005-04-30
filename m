Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVD3NnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVD3NnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 09:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVD3NnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 09:43:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17296 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261219AbVD3NnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 09:43:17 -0400
Date: Sat, 30 Apr 2005 15:40:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
Message-ID: <20050430134046.GD585@openzaurus.ucw.cz>
References: <20050421111346.GA21421@elf.ucw.cz> <20050429061825.36f98cc0.akpm@osdl.org> <Pine.LNX.4.61.0504290734220.30771@montezuma.fsmlabs.com> <20050430024748.19d44a8d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050430024748.19d44a8d.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It looks like the device 
> > being suspended never went through pci_device_enable() (e.g. ethernet 
> > interface wasn't up). It's harmless right now.
> 
> Everything's up.  Perhaps we're trying to disable devices more than once?

Maybe userspace ifconfigs eth0 down, then we device_suspend it?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

