Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUITThY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUITThY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUITThY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:37:24 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:28123 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267251AbUITThV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:37:21 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Tue, 21 Sep 2004 03:38:00 +0800
User-Agent: KMail/1.5.4
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net
References: <1094783022.2667.106.camel@gaston> <1095672428.13735.3.camel@gaston> <20040920085214.0abe33a0.akpm@osdl.org>
In-Reply-To: <20040920085214.0abe33a0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409210338.00863.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 September 2004 23:52, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >  Andrew, Any reason why this patch isn't upstream ? The recent changes
> >  to fbdev in 2.6.9-* are a regression and we need this patch to get bac
> >  the video=ofonly feature.
>
> Well I have a whole bunch of fbcon/fbdev patches here, but at some point
> one needs to plug the flow so we can get 2.6.9 out the door.  And nobody
> told me (until now) that we had a problem.
>
> Tony, which of the below shold be merged into 2.6.9?
>

> fbdev-fix-userland-compile-breakage.patch
> fbcon-fix-fbcons-setup-routine.patch
> fbdev-arrange-driver-order-in-makefile.patch

These 3 need to go to mainline.

> fbdev-fix-logo-drawing-failure-for-vga16fb.patch
> fbcon-fix-setup-boot-options-of-fbcon.patch

These 2 need not go immediately as no one will probably notice what they
fixed.

> radeonfb-fix-warnings-about-uninitialized-variables.patch

I haven't seen this.

> fbdev-remove-unnecessary-banshee_wait_idle-from-tdfxfb.patch
> fbdev-initialize-i810fb-after-agpgart.patch
> fbdev-pass-struct-device-to-class_simple_device_add.patch
> fbdev-add-tile-blitting-support.patch
> fbdev-fix-scrolling-corruption.patch
> fbdev-remove-i810fb-explicit-agp-initialization-hack.patch

These can wait.

Tony


