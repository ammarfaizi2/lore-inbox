Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbVKSBeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVKSBeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKSBeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:34:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:4285 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030266AbVKSBeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:34:03 -0500
Date: Fri, 18 Nov 2005 17:18:40 -0800
From: Greg KH <greg@kroah.com>
To: Voluspa <lista1@telia.com>
Cc: linux-kernel@vger.kernel.org, rajesh.shah@intel.com, kjarvel@home.se,
       howarth@bromo.msbb.uc.edu
Subject: Re: PCI error on x86_64 2.6.13 kernel
Message-ID: <20051119011840.GB28175@kroah.com>
References: <20051118080440.4aaf4a6d.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118080440.4aaf4a6d.lista1@telia.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 08:04:40AM +0100, Voluspa wrote:
> 
> On 2005-11-18 0:24:51 Rajesh Shah wrote:
> >On Wed, Oct 26, 2005 at 11:06:05PM +0200, Niklas Kallman wrote:
> >>Jack Howarth wrote:
> >>> Has anyone reported the following? For both of the 2.6.13 based
> >>> kernels released so far on Fedora Core 4 for x86_64, we are seeing
> >>> error messages of the form...
> >>> 
> >>> Oct  3 11:21:48 XXXXX  kernel:   MEM window: d0200000-d02fffff
> >>> Oct  3 11:21:48 XXXXX  kernel:   PREFETCH window: disabled.
> >>> Oct  3 11:21:48 XXXXX  kernel: PCI: Failed to allocate mem resource #6:20000 \
> >>> f0000000 for 0000:09:00.0 
> >
> >I ran into a similar problem, and posted a fix, see
> >http://marc.theaimsgroup.com/?l=linux-pci&m=113225006603745&w=2
> >
> >Can you try it to see if this problem goes away?
> 
> Even though your patch touched arch/i386/pci/i386.c I tried it in my pure AMD64
> environment. No luck... I remember when this PCI error turned up, but since it
> was non-fatal I shrugged it off. Early 2.6.13 it was. Booting back on my
> non-distro, plain kernel.org notebook I indeed see that 2.6.11.11 and 2.6.12
> are fine.

Others are reporting this problem too.

Is there any way you could be able to run 'git bisect' between 2.6.12
and 2.6.13 to try to find the offending changeset?  I would really
appreciate it.

thanks,

greg k-h
