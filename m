Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVBGVWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVBGVWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVBGVWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:22:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:18865 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261332AbVBGVVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:21:22 -0500
Date: Mon, 7 Feb 2005 12:43:19 -0800
From: Greg KH <gregkh@suse.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: Enrico Bartky <DOSProfi@web.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Maarten Deprez <maartendeprez@scarlet.be>
Subject: Re: M7101
Message-ID: <20050207204319.GB26445@kroah.com>
References: <41DC59A4.1070006@web.de> <20050206152615.1ab7498c.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206152615.1ab7498c.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 03:26:15PM +0100, Jean Delvare wrote:
> Hi Enrico,
> 
> Sorry for the delay.
> 
> > I have a board with the ALI M7101 chip, but I can't activate it in
> > BIOS.  I tried to compile the prog/hotplug/m7101.c but I seen that
> > this is only  for 2.4 Kernels. Is there a module for 2.6?
> 
> The prog/hotplug/m7101.c (from the lm_sensors project) was a quick hack
> and only works with 2.4 kernels, as you noticed. For 2.6 kernels, the
> prefered solution is known as PCI quirks (drivers/pci/quirks.c). I can
> see that you already found that and proposed a patch for the 2.6 kernel
> here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110606482902883
> 
> Maarten Deprez then converted it to the proper kernel coding-style:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110726276414532
> 
> I invite you to test the new patch and confirm that it works for you.
> 
> Any chance we could get the PCI folks to review the code and push it
> upwards if it is OK?

I need it resent with the fixes, and a "Signed-off-by:" line to do that
:)

Also, a pci_get_* is called without a matching put.

thanks,

greg k-h
