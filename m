Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264813AbUEZWj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264813AbUEZWj7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 18:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbUEZWj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 18:39:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:49030 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264813AbUEZWj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 18:39:58 -0400
Date: Wed, 26 May 2004 15:39:01 -0700
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resume enhancement: restore pci config space
Message-ID: <20040526223900.GA7578@kroah.com>
References: <20040526203524.GF2057@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526203524.GF2057@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 10:35:26PM +0200, Arjan van de Ven wrote:
> Hi,
> 
> The patch below enhances the PCI layer with 2 things
> 1) enable and busmaster state are stored in the pci device struct
> 2) pci config space is stored to the pci device struct
> 
> with that, it is possible to make a generic pci resume method that restores
> config space and reenables the device, including busmaster when appropriate.
> 
> One can rightfully argue that the driver resume method should do this, and
> yes that is right. So the patch only does it for devices that don't have a
> resume method. Like the main PCI bridge on my testbox of which the bios so
> nicely forgets to restore the bus master bit during resume.. With this patch
> my testbox resumes just fine while it, well, wasn't all too happy as you can
> imagine without a busmaster pci bridge.
> 
> Comments?

This looks good to me, I've applied it to my trees, thanks.

Hm, it still doesn't let me resume properly on my laptop when I suspend
to ram, but I'm trying to track that down...

thanks,

greg k-h
