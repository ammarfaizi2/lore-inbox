Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTLRAZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 19:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264883AbTLRAZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 19:25:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:12951 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264881AbTLRAZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 19:25:18 -0500
Date: Wed, 17 Dec 2003 16:24:44 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_get_slot()
Message-ID: <20031218002444.GI6258@kroah.com>
References: <20031015183213.GG16535@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015183213.GG16535@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 07:32:13PM +0100, Matthew Wilcox wrote:
> 
> Hi Linus.
> 
> tg3.c has a bug where it can find the wrong 5704 peer on a machine with
> PCI domains.  The problem is that pci_find_slot() can't distinguish
> whether it has the correct domain or not.
> 
> This patch fixes that problem by introducing pci_get_slot() and converts
> tg3 to use it.  It also fixes another problem where tg3 wouldn't find
> a peer on function 7 (0 to <8, not 0 to <7).

I've applied the pci portions of this patch to my trees and will send it
on after 2.6.0 is out.

thanks,

greg k-h
