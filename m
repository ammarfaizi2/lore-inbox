Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWFCHOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWFCHOd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 03:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWFCHOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 03:14:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35857 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932592AbWFCHOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 03:14:33 -0400
Date: Tue, 30 May 2006 20:01:35 +0000
From: Pavel Machek <pavel@suse.cz>
To: David Liontooth <liontooth@cogweb.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB devices fail unnecessarily on unpowered hubs
Message-ID: <20060530200134.GB4074@ucw.cz>
References: <447EB0DC.4040203@cogweb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447EB0DC.4040203@cogweb.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Starting with 2.6.16, some USB devices fail unnecessarily on unpowered
> hubs. Alan Stern explains,
> 
> "The idea is that the kernel now keeps track of USB power budgets.  When a 
> bus-powered device requires more current than its upstream hub is capable 
> of providing, the kernel will not configure it.
> 
> Computers' USB ports are capable of providing a full 500 mA, so devices
> plugged directly into the computer will work okay.  However unpowered hubs
> can provide only 100 mA to each port.  Some devices require (or claim they
> require) more current than that.  As a result, they don't get configured
> when plugged into an unpowered hub."

Actually I have exactly opposite problem: my computer (spitz) can't
supply full 500mA on its root hub, and linux tries to power up
'hungry' devices, anyway, leading to very weird behaviour.

-- 
Thanks for all the (sleeping) penguins.
