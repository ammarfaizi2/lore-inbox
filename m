Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVASBDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVASBDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 20:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVASBDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 20:03:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:7589 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261517AbVASBDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 20:03:30 -0500
Date: Tue, 18 Jan 2005 17:03:23 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH] PCI: add PCI Express Port Bus Driver subsystem
Message-ID: <20050119010323.GA23090@kroah.com>
References: <200501190159.j0J1xi4Q024191@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501190159.j0J1xi4Q024191@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 05:59:44PM -0800, long wrote:
> On Tue Jan 18 11:41:01 2005 Greg KH wrote:
> >> >
> >> >
> >> > This puts all of the pcie "port" structures in /sys/devices/  Shouldn't
> >> > you make the parent of the device you create point to the pci_dev
> >> > structure that's passed into this function?  That would make the sysfs
> >> > tree a lot saner I think.
> >> 
> >> The patch makes the parent of the device point to the pci_dev structure
> >> that is passed into this function. If you think it is cleaner that the
> >> patch should not, I will update the patch to reflect your input.
> >
> >That would be great, but it doesn't show up that way on my box.  All of
> >the portX devices are in /sys/devices/ which is what I don't think you
> >want.  I would love for them to have the parent of the pci_dev structure
> >:)
> 
> Agree. Thanks for your inputs. The patch below include the changes based
> on your previous post.

Hm, that seems like a pretty big patch just to add a pointer to a parent
device :)

What really does this patch do?  What does the sysfs tree now look like?

thanks,

greg k-h
