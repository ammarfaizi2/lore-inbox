Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUKDA5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUKDA5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbUKDA5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:57:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:37029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261925AbUKDAvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:51:21 -0500
Date: Wed, 3 Nov 2004 16:51:08 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
Message-ID: <20041104005107.GA15301@kroah.com>
References: <20041103091039.GA22469@taniwha.stupidest.org> <41891980.6040009@pobox.com> <20041103190757.GA25451@taniwha.stupidest.org> <41892DE3.5040402@pobox.com> <20041104002138.GA32691@kroah.com> <20041104003734.GA17467@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104003734.GA17467@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 04:37:34PM -0800, Chris Wedgwood wrote:
> On Wed, Nov 03, 2004 at 04:21:39PM -0800, Greg KH wrote:
> 
> > Due to the change in the way the function works, I'm slowly changing
> > drivers over to the new function.  It's just too dangerous over time
> > to leave it alone.
> 
> this is what i'm not clear about --- how does it work differently?

Read the code :)

In short, pci_module_init() on 2.4 would return the number of pci
devices bound to the device, on 2.6, it just always returns 0 if the
driver was successfully registered, no knowledge of how many devices
bound are ever returned.

Hope this helps,

greg k-h
