Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267568AbUIHQGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267568AbUIHQGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUIHQDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:03:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50576 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268474AbUIHQCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:02:47 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: multi-domain PCI and sysfs
Date: Wed, 8 Sep 2004 09:02:14 -0700
User-Agent: KMail/1.7
Cc: "David S. Miller" <davem@davemloft.net>, willy@debian.org,
       linux-kernel@vger.kernel.org
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409072125.41153.jbarnes@engr.sgi.com> <9e47339104090723012190c73a@mail.gmail.com>
In-Reply-To: <9e47339104090723012190c73a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409080902.14640.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 7, 2004 11:01 pm, Jon Smirl wrote:
> X on GL is going to eliminate all device access from X. Everything
> will be handled from the OpenGL layer. When everything is finished
> even the OpenGL layer won't do hardware access either, it will IOCTL
> the DRM driver to do it. In the final solution the only user of the
> VGA control should be the secondary card reset program.

Oh right, I forgot.  Anyway, the card reset program needs to get at this stuff 
somehow.

> Where is the PCI segment base address stored in the PCI driver
> structures? I'm still having trouble with the fact that the PCI driver
> does not have a clear structure representing a PCI segment.  Shouldn't
> there be a structure corresponding to a segment?

That would be nice, maybe an extra resource or something?  I haven't looked at 
the sparc code, but it probably deals with this (sn2 has platform specific 
functions to get the base address for a bus).

> From what I understand right now the SN2 machine can not have two
> active VGA cards since it does not have two PCI segments. Without two
> segments there is no way to tell the legacy addresses apart.

sn2 does have multiple PCI segments, we just don't export them yet.

Jesse
