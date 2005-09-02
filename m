Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbVIBVZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbVIBVZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbVIBVZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:25:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:51085 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161053AbVIBVZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:25:47 -0400
Date: Fri, 2 Sep 2005 08:53:39 -0700
From: Greg KH <greg@kroah.com>
To: iSteve <isteve@rulez.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SysFS, module names and .name
Message-ID: <20050902155338.GA13648@kroah.com>
References: <43176488.2080608@rulez.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43176488.2080608@rulez.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 10:28:56PM +0200, iSteve wrote:
> Greetings,
> in sysfs, /sys/bus/*/drivers lists the driver names, with their exported 
> .name (eg. '.name = "EMU10K1_Audigy"' in the module code, from now on 
> 'driver name'). In /sys/modules, the kernel modules are listed with 
> their module name, eg. snd_emu10k1. However, it seems to me that in 
> sysfs, there is no way in particular to tell, which module has which 
> .name. That is, that snd_emu10k1 is EMU10K1_Audigy and vice versa.
> 
> I wonder whether it wouldn't be possible to add a symlink to the 
> particular module from the driver, and/or from the module to the driver, 
> so the list of devices handled by the module and the module name would 
> be accessible. This way, I would know which driver name corresponds to 
> which module name and vice versa.

It's already automatically created for some bus drivers (like USB).  I
had a simple patch to enable this for PCI, but haven't gotten around to
changing every single pci driver to enable it.  If you want to do so,
it isn't tough at all.

thanks,

greg k-h
