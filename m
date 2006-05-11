Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWEKARM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWEKARM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 20:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWEKARM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 20:17:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:17853 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965102AbWEKARL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 20:17:11 -0400
Date: Wed, 10 May 2006 17:12:26 -0700
From: Greg KH <greg@kroah.com>
To: Henne <henne@nachtwindheim.de>
Cc: arjan@infradead.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
       greg@kroah.org
Subject: Re: [ALSA] add __devinitdata to all pci_device_id
Message-ID: <20060511001226.GA27465@kroah.com>
References: <445673F0.4020607@nachtwindheim.de> <44577C75.8040202@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44577C75.8040202@nachtwindheim.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 05:36:21PM +0200, Henne wrote:
> Henne wrote:
> >On Mon, May 01, 2006 at 06:49:24PM +0200, Arjan van de Ven wrote:
> >
> > > are you really really sure you want to do this?
> > > These structures are exported via sysfs for example, I would think this
> > > is quite the wrong thing to make go away silently...
> 
> 
> I tested that on my system.
> 
> make oldconfig
> <comment out CONFIG_HOTPLUG>
> <install and booting that kernel>
> <reading vendor device, etc. of built-in devices in sysfs>
> <adding new ID's via new_id>

Hm, I don't think you really disabled CONFIG_HOTPLUG, as that file will
not be present if you disable that option.

So I think your testing was invalid.

thanks,

greg k-h
