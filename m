Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWEWSvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWEWSvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWEWSvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:51:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:22670 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932075AbWEWSvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:51:42 -0400
Date: Tue, 23 May 2006 11:49:24 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: edac driver names in sysfs.
Message-ID: <20060523184924.GB29044@kroah.com>
References: <20060522022912.GS8250@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522022912.GS8250@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 10:29:12PM -0400, Dave Jones wrote:
> EDAC does something funky that no other afaik seems to do.
> 
> #define edac_xstr(s) edac_str(s)
> #define edac_str(s) #s
> #define EDAC_MOD_STR edac_xstr(KBUILD_BASENAME)
> 
> And then..
> 
> 	.name = EDAC_MOD_STR,
> 
> in its pci_driver structs.
> This leads to it looking a bit 'odd' in /sys/bus/pci/drivers
> compared to the others.
> 
> /sys/bus/pci/drivers/\"e752x_edac\"/
> 
> Is correcting this to remove the quotes likely to break anything
> in userspace ?

In the /sys/bus/pci/drivers/ directory?  No, it should be fixed.  Driver
names shouldn't have quotes or spaces or / in them.  I've fixed up
almost all of the space issues, but they seem to keep cropping up every
once in a while (an example of this is the name "Intel ICH" which should
be fixed up...

thanks,

greg k-h
