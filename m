Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVC1XDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVC1XDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVC1XDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:03:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:3774 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262105AbVC1XB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:01:26 -0500
Date: Mon, 28 Mar 2005 14:58:18 -0800
From: Greg KH <gregkh@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, mj@ucw.cz, openib-general@openib.org
Subject: Re: [PATCH] disable MSI for AMD-8131
Message-ID: <20050328225818.GA4919@kroah.com>
References: <20050306202845.GE8486@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306202845.GE8486@mellanox.co.il>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 10:28:45PM +0200, Michael S. Tsirkin wrote:
> Greg, Martin,
> 
> The AMD-8131 I/O APIC (device id 1022:7450/7451) does not support message
> signalled interrupts. Thus, if a device driver attempts to enable msi,
> it will suceed, but interrupts are not actually delivered to the cpu.
> The Nforce chipsets do not seem to have this limitation.
> AMD confirmed that MSI mode is unsupported with this APIC.
> 
> The following patch adds a flag to pci quirks to detect this and disable msi.
> 
> Please let me know what do you think.
> 
> Signed-off-by: Michael S. Tsirkin <mst@mellano.co.il>

Looks good, applied, thanks.

greg k-h
