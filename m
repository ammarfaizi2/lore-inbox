Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268258AbUHGAL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268258AbUHGAL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 20:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUHGAL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 20:11:58 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:56228 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268258AbUHGALz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 20:11:55 -0400
Date: Sat, 7 Aug 2004 01:11:21 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Ian Romanick <idr@us.ibm.com>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: DRM function pointer work..
In-Reply-To: <20040806171641.14189.qmail@web14928.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0408070100360.13601@skynet>
References: <20040806171641.14189.qmail@web14928.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> fbdev is in exactly this model and it isn't causing anyone problems.
> The simple rule is that if you want to upgrade fbdev past the current
> version you have to do it in entirety. You do that for fbdev but
> pulling bk://fbdev.bkbits.net/. But Joe user doesn't do that, that is
> something only developers do.

fbdev only has one distribution vector - the kernel, DRM has multiple
distribution vectors, kernel, DRI snapshots, X releases, they all contain
their own DRM modules, also people with older kernels should be able to
use new drivers with little hassle, if we force people to upgrade their
kernel we are restricting what we allow them to do now ...

If we do go for a library split, we should use the kernel config system
like I mentioned and fight any attempts to change it, to re-iterate, if
you build drm into the kernel you have to build the graphics drivers in as
well, (we can use a symbol to enforce it), if you build the drm as a
module all drivers have to be modular, and the DRM makefile installs the
core DRM, we could also create a drm_ver.h file that gets
generateed at compile time automatically and then included into
both drm core and module at build time, if this differs just refuse to
load and stick a FAQ up telling the user they are messing something up ..

> The key here is that distributions release new kernels at a rapid pace.
> This is not X where we get a new release every five years. The standard
> mechanism for upgrading device drivers in Linux is to add them to the
> kernel and wait for a release.  If DRM uses that mechanism for
> distribution we won't have problems.
>

Like Keith I don't buy this argument too much either, I think we should be
able to continue as much as possible with what people can do now ..
especially snapshot type systems..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

