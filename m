Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbVK3SXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVK3SXx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 13:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbVK3SXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 13:23:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751498AbVK3SXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 13:23:52 -0500
Date: Wed, 30 Nov 2005 10:23:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Grant Coady <gcoady@gmail.com>
Subject: Re: [GIT PATCH] USB patches for 2.6.15-rc3
In-Reply-To: <20051130055607.GA4406@kroah.com>
Message-ID: <Pine.LNX.4.64.0511301018280.3099@g5.osdl.org>
References: <20051130055607.GA4406@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Nov 2005, Greg KH wrote:
>
>  include/linux/pci_ids.h           |    3 --
> 
> Grant Coady:
>       pci_ids.h: remove duplicate entries

Why is this in the USB tree, and WHY THE HELL DOES IT EXIST IN THE FIRST 
PLACE?

Not only does it have absolutely nothing to do with USB, it's totally 
bogus and incorrect. The commit log is also non-sensical, since it points 
to a commit that doesn't even exist in that tree.

It causes

	drivers/ide/pci/amd74xx.c:77: error: PCI_DEVICE_ID_AMD_CS5536_IDE undeclared here (not in a function)

Grr.

That hwmon thing didn't seem to have anything to do with usb either.

		Linus
