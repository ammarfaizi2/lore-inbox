Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbUKDA6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUKDA6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUKDA5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:57:40 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:42208 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262030AbUKDAxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:53:43 -0500
Date: Wed, 3 Nov 2004 16:53:27 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
Message-ID: <20041104005327.GA17670@taniwha.stupidest.org>
References: <20041103091039.GA22469@taniwha.stupidest.org> <41891980.6040009@pobox.com> <20041103190757.GA25451@taniwha.stupidest.org> <41892DE3.5040402@pobox.com> <20041104002138.GA32691@kroah.com> <20041104003734.GA17467@taniwha.stupidest.org> <20041104005107.GA15301@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104005107.GA15301@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 04:51:08PM -0800, Greg KH wrote:

> Read the code :)

fair enough

> In short, pci_module_init() on 2.4 would return the number of pci
> devices bound to the device, on 2.6, it just always returns 0 if the
> driver was successfully registered, no knowledge of how many devices
> bound are ever returned.

ok, this makes perfect sense now -- i have patches to an out-of-tree
driver (madwifi) that broke recently because it does

	 if (pci_register_drive(...) <= 0) {
	    /* error */

sort of thing.

thanks!
  --cw
