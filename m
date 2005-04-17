Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVDQXqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVDQXqG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVDQXqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:46:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:8579 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261563AbVDQXqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:46:03 -0400
Date: Sun, 17 Apr 2005 14:58:51 -0700
From: Greg KH <greg@kroah.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Kylene Hall <kjhall@us.ibm.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] tpm: Stop taking over the non-unique lpc bus PCI ID, Also timer, stack and enum fixes
Message-ID: <20050417215850.GA3178@kroah.com>
References: <Pine.LNX.4.61.0504151611390.24192@dyn95395164> <20050415235250.GA24204@kroah.com> <21d7e9970504161705a129893@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970504161705a129893@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 10:05:27AM +1000, Dave Airlie wrote:
> > NO!  DO NOT use pci_find_device().  It is broken for systems with pci
> > hotplug (which means any pci system).  Please use the way the driver
> > currently works, that is correct.
> 
> But its not an LPC driver, it only uses a small piece of the LPC, we
> really do need some sort of bridge driver layer or something for
> these, then other drivers can sit on top of that,

Then the TPM driver can provide that layer.

> The DRM still uses pci_find_device for the exact same reason, the fb
> drivers take the PCI device and we have been told we can't use the
> proper interface, hence one of the needs to merge fb and DRM..

Exactly.

thanks,

greg k-h
