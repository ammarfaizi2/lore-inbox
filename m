Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266581AbUBDXNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266601AbUBDXNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:13:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:16048 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266581AbUBDXNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:13:39 -0500
Date: Wed, 4 Feb 2004 15:13:24 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI / OF linkage in sysfs
Message-ID: <20040204231324.GA5078@kroah.com>
References: <1075878713.992.3.camel@gaston> <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 02:08:58PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 4 Feb 2004, Benjamin Herrenschmidt wrote:
> > 
> > This patch adds a "devspec" property to all PCI entries in sysfs
> > that provides the full "Open Firmware" path to each device on
> > PPC and PPC64 platforms that have Open Firmware support.
> 
> Wouldn't it make more sense to go the other way? Ie have the PCI devices 
> be pointed to from the OF paths?

Or, if you really want to be able to get the OF info from the pci device
in sysfs, why not create a symlink in the pci device directory pointing
to your OF path in sysfs?  That would seem like the best option.

thanks,

greg k-h
