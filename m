Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUIDWRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUIDWRo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 18:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUIDWRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 18:17:44 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:38122 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263769AbUIDWRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 18:17:41 -0400
Date: Sat, 4 Sep 2004 23:17:40 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <Pine.LNX.4.58.0409041333230.25475@skynet>
Message-ID: <Pine.LNX.4.58.0409042311270.24528@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> 
 <Pine.LNX.4.58.0409040145240.25475@skynet>  <20040904102914.B13149@infradead.org>
  <41398EBD.2040900@tungstengraphics.com>  <20040904104834.B13362@infradead.org>
  <413997A7.9060406@tungstengraphics.com>  <20040904112535.A13750@infradead.org>
  <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com>
  <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com>
  <4139B03A.6040706@tungstengraphics.com>  <Pine.LNX.4.58.0409041311020.25475@skynet>
 <1094301014.2801.10.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409041333230.25475@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually after sleeping on this, I've just realised technically whether
the code is in a core separate module or driver module is only going to
affect maybe 5% of the work and the Makefiles/Kconfig at the end, so
following the principles of a)least surprise, b) kernel must remain
stable, I think I can proceed with moving stuff into libraries and the
likes without making the final decision until later, we will probably
start with having the library type code in the driver (where it is now)
and make it possible to change later, as it evolves..

I'll do some more research...

Dave.

 >
> It's still useful, it just is built into the drivers as a library rather
> than the kernel, and the actual "core" is just a major number sharing
> scheme, again the only advantage of building the library functions into
> the kernel or as a separate module are a small memory saving on a rare use
> case, hardly an astounding reason,
>
> New functions added to the library can be made available to new drivers,
> and vendors can ship their own set of library sources and not use
> the kernels ones..
>
> Dave.
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

