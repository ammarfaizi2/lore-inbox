Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVBSM3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVBSM3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 07:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVBSM3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 07:29:16 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:34985 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261701AbVBSM3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 07:29:14 -0500
To: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Hotplug blacklist and video devices
In-Reply-To: <9e47339105021813146cf69759@mail.gmail.com>
References: <9e4733910502181251ea2b95e@mail.gmail.com> <20050218210822.GB8588@nostromo.devel.redhat.com> <20050218210822.GB8588@nostromo.devel.redhat.com> <9e47339105021813146cf69759@mail.gmail.com>
Date: Sat, 19 Feb 2005 12:29:13 +0000
Message-Id: <E1D2TjV-0007r9-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:

> For example I'm looking at making changes to DRM such that DRM will
> require the corresponding framebuffer driver to be loaded. If you back
> up further this is part of fixing X so that it won't mess with the
> hardware from user space. Mode setting would come from the framebuffer
> driver instead of the X 2D XAA driver.

Please don't until all the framebuffer drivers are able to deal with
suspend and resume (which will also require some mechanism to switch
backlights back on). Currently, it's far easier to restore some amount
of state on a standard VGA or VESA mode. There's no real support for
doing so with most accelerated framebuffers.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
