Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUD1ARm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUD1ARm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbUD1ARm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:17:42 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:39584 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264531AbUD1AOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:14:51 -0400
Date: Wed, 28 Apr 2004 01:14:49 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: raven@themaw.net
Cc: Paul Jackson <pj@sgi.com>, Erdi Chen <erdi.chen@digeo.com>,
       davem@redhat.com, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
In-Reply-To: <Pine.LNX.4.58.0404272234320.1547@donald.themaw.net>
Message-ID: <Pine.LNX.4.58.0404280111430.2125@skynet>
References: <20040426204947.797bd7c2.pj@sgi.com>
 <Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au>
 <Pine.LNX.4.58.0404272234320.1547@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > >       CC [M]  drivers/char/drm/ffb_drv.o
> > >     In file included from drivers/char/drm/ffb_drv.c:336:
> > >     drivers/char/drm/drm_drv.h:547: error: `ffb_PCI_IDS' undeclared here (not in a function)
> > >     drivers/char/drm/drm_drv.h:547: error: initializer element is not constant
> > >     drivers/char/drm/drm_drv.h:547: error: (near initialization for `ffb_pciidlist[0]')
> > >     drivers/char/drm/ffb_drv.c:225: warning: `ffb_count_card_instances' defined but not used
> > >     make[3]: *** [drivers/char/drm/ffb_drv.o] Error 1

> It appears that for 2.6.6-rc2-mm2 this should be:
>
> #define ffb_PCI_IDS { 0,0,0 }
>
> which allows the kernel to build.

this should be fixed in the next pull from the DRM bk tree, bk seems to be
down so I can't confirm the fix is in there at the moment ...

Looking at the oops it looks like the framebuffer device is crashing, can
you trry building it without the ffb DRM and see if it still crashes?


Thanks,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

