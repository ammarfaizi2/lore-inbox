Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUBDWJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbUBDWJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:09:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:42466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266617AbUBDWJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:09:02 -0500
Date: Wed, 4 Feb 2004 14:08:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PCI / OF linkage in sysfs
In-Reply-To: <1075878713.992.3.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
References: <1075878713.992.3.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> This patch adds a "devspec" property to all PCI entries in sysfs
> that provides the full "Open Firmware" path to each device on
> PPC and PPC64 platforms that have Open Firmware support.

Wouldn't it make more sense to go the other way? Ie have the PCI devices 
be pointed to from the OF paths?

I'd prefer to avoid having OF-specific files in a PCI directory. That just 
leads to inherently unportable user mode stuff. In contrast, having the OF 
directory entry that points to the hardware (PCI) entry makes perfect 
sense.

umm?

		Linus
