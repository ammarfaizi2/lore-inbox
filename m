Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269913AbUIDMR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269913AbUIDMR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUIDMR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:17:57 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:31443 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269913AbUIDMRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:17:55 -0400
Date: Sat, 4 Sep 2004 13:17:54 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <4139B03A.6040706@tungstengraphics.com>
Message-ID: <Pine.LNX.4.58.0409041311020.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
 <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org>
 <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org>
 <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org>
 <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com>
 <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com>
 <4139B03A.6040706@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Are you suggesting for instance, that RedHat might pick up individual drivers
> out of Xorg or better still Mesa, rather than waiting for a full stable
> release?  That would probably be the biggest help - by comparison kernel
> releases are very frequent.

Lets take an example, I'm DA graphics card vendor, I write a DRI driver
for my brand new 3d graphics cards (they rock btw :-), people buy loads of
them, I want to give them something on my website that they can deploy to
use their new card, like a driver for ANotherOS. Now I just want to give
them an XFree DDX, DRI driver and a drm module (in source form, that they
can use no matter what kernel), now at the moment no matter what kernel
they have, the DRM is a completly separate entity - the DRM code deals
with it,

If we make a library split that sits inside the kernel, their DRM can
stop working if someone busts the interface, hence the idea of having the
core reg/dereg in the kernel, and locking it down, then they can ship a
complete DRM source tree, and do as they wish as long as they interface
properly with the core...

Dave.


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

