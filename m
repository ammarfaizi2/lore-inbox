Return-Path: <linux-kernel-owner+w=401wt.eu-S1751979AbWLNXvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWLNXvX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWLNXvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:51:23 -0500
Received: from cantor2.suse.de ([195.135.220.15]:60916 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbWLNXvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:51:22 -0500
Date: Thu, 14 Dec 2006 15:50:59 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1: gotemp: memset(..., 0) error
Message-ID: <20061214235059.GA11375@kroah.com>
References: <20061211005807.f220b81c.akpm@osdl.org> <20061213130559.GD3851@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213130559.GD3851@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 02:05:59PM +0100, Adrian Bunk wrote:
> <--  snip  -->
> 
> ...
> NOT FOR MAINLINE!
> 
> This is for the driver tutorial I give.  It will not be included in the
> mainline kernel tree ever.  Use the ldusb driver that is already there
> instead for this device.
> 
> This is only a teaching tool.
> ...
> +       pkt = kmalloc(sizeof(*pkt), GFP_ATOMIC);
> +       if (!pkt)
> +               return -ENOMEM;
> +       memset(pkt, sizeof(*pkt), 0x00);
> ...
> 
> <--  snip  -->
> 
> 
> Lesson 1:
> Write an USB driver.
> 
> Lesson 2:
> Correct the memset() argument order or use kzalloc().

Heh, thanks, I've now fixed that up in my tree.

greg k-h
