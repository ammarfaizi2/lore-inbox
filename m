Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWFAJ54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWFAJ54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWFAJ54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:57:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964868AbWFAJ5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:57:55 -0400
Date: Thu, 1 Jun 2006 03:01:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Liontooth <liontooth@cogweb.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
Message-Id: <20060601030140.172239b0.akpm@osdl.org>
In-Reply-To: <447EB0DC.4040203@cogweb.net>
References: <447EB0DC.4040203@cogweb.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 02:18:20 -0700
David Liontooth <liontooth@cogweb.net> wrote:

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
> 
> http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg43480.html
> 
> This is generating a lot of grief and appears to be unnecessarily
> strict. Common USB sticks with a MaxPower value just above 100mA, for
> instance, typically work fine on unpowered hubs supplying 100mA.
> 
> Is a more user-friendly solution possible? Could the shortfall
> information be passed to udev, which would allow rules to be written per
> device?
> 

(added linux-usb cc)

Yes, it sounds like we're being non-real-worldly here.  This change
apparently broke things.  Did it actually fix anything as well?
