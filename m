Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268839AbUIHGBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268839AbUIHGBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268847AbUIHGBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:01:43 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:16362 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268839AbUIHGBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:01:40 -0400
Message-ID: <9e47339104090723012190c73a@mail.gmail.com>
Date: Wed, 8 Sep 2004 02:01:39 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: multi-domain PCI and sysfs
Cc: "David S. Miller" <davem@davemloft.net>, willy@debian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200409072125.41153.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409072115.09856.jbarnes@engr.sgi.com>
	 <20040907211637.20de06f4.davem@davemloft.net>
	 <200409072125.41153.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004 21:25:41 -0700, Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> you're up for it.  My hope is that we can have a unified Linux device access
> method in X and get rid of all (or at least most) of the ppc/sparc/ia64/etc.
> specific hacks in the tree...

X on GL is going to eliminate all device access from X. Everything
will be handled from the OpenGL layer. When everything is finished
even the OpenGL layer won't do hardware access either, it will IOCTL
the DRM driver to do it. In the final solution the only user of the
VGA control should be the secondary card reset program.

Where is the PCI segment base address stored in the PCI driver
structures? I'm still having trouble with the fact that the PCI driver
does not have a clear structure representing a PCI segment.  Shouldn't
there be a structure corresponding to a segment?

>From what I understand right now the SN2 machine can not have two
active VGA cards since it does not have two PCI segments. Without two
segments there is no way to tell the legacy addresses apart.

-- 
Jon Smirl
jonsmirl@gmail.com
