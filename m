Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264614AbUD1CWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264614AbUD1CWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 22:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbUD1CWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 22:22:47 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:55822 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264614AbUD1CWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 22:22:41 -0400
Date: Wed, 28 Apr 2004 10:29:46 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Dave Airlie <airlied@linux.ie>
cc: Paul Jackson <pj@sgi.com>, Erdi Chen <erdi.chen@digeo.com>,
       davem@redhat.com, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
In-Reply-To: <Pine.LNX.4.58.0404280111430.2125@skynet>
Message-ID: <Pine.LNX.4.58.0404281025060.651@wombat.indigo.net.au>
References: <20040426204947.797bd7c2.pj@sgi.com>
 <Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au>
 <Pine.LNX.4.58.0404272234320.1547@donald.themaw.net> <Pine.LNX.4.58.0404280111430.2125@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Dave Airlie wrote:

> 
> > > >       CC [M]  drivers/char/drm/ffb_drv.o
> > > >     In file included from drivers/char/drm/ffb_drv.c:336:
> > > >     drivers/char/drm/drm_drv.h:547: error: `ffb_PCI_IDS' undeclared here (not in a function)
> > > >     drivers/char/drm/drm_drv.h:547: error: initializer element is not constant
> > > >     drivers/char/drm/drm_drv.h:547: error: (near initialization for `ffb_pciidlist[0]')
> > > >     drivers/char/drm/ffb_drv.c:225: warning: `ffb_count_card_instances' defined but not used
> > > >     make[3]: *** [drivers/char/drm/ffb_drv.o] Error 1
> 
> > It appears that for 2.6.6-rc2-mm2 this should be:
> >
> > #define ffb_PCI_IDS { 0,0,0 }
> >
> > which allows the kernel to build.
> 
> this should be fixed in the next pull from the DRM bk tree, bk seems to be
> down so I can't confirm the fix is in there at the moment ...
> 
> Looking at the oops it looks like the framebuffer device is crashing, can
> you trry building it without the ffb DRM and see if it still crashes?
> 

I'll investigate but I think that, either I need the fb device or
X -configure has it wrong. It thinks I have devices fb0 and fb1.

One thing I can do is disable all the graphics devices except the one that 
I have. I left the others in to test out the build.

I have dual cgsix (TGX) cards in my Sun.

Ian

