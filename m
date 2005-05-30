Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVE3JNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVE3JNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVE3JNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:13:34 -0400
Received: from witte.sonytel.be ([80.88.33.193]:6082 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261568AbVE3JNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:13:32 -0400
Date: Mon, 30 May 2005 11:12:54 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dave Airlie <airlied@gmail.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Dave Airlie <airlied@linux.ie>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] DRM depends on ???
In-Reply-To: <21d7e99705053001544fe883d5@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0505301111250.22798@numbat.sonytel.be>
References: <Pine.LNX.4.62.0505282333210.5800@anakin>  <20050528215005.GA5990@redhat.com>
  <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com>  <Pine.LNX.4.58.0505290809180.9971@skynet>
  <Pine.LNX.4.62.0505292157130.12948@numbat.sonytel.be> 
 <64148E06-2DFA-41A5-9D86-5F34DCAAF9F4@mac.com> 
 <Pine.LNX.4.62.0505301002400.22798@numbat.sonytel.be>
 <21d7e99705053001544fe883d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, Dave Airlie wrote:
> > OK. So we still need the dependency on PCI.
> 
> at the moment yes but I'm think we will have to remove this as soon as
> we get the Sparc ffb stuff up and running again, the ffb driver
> doesn't do any PCI stuff, we have some code around but we haven't had
> any testing done on it and I'm sure its rotting away, if a maintainer
> turns up for sparc ffb, then the PCI requirement is gone..

So you will have to change it to 'PCI || (FB_SBUS && SPARC64)', right?
Simply dropping the PCI requirement is wrong.

> I can add the PCI dependency for now...

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
