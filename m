Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTFBVIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTFBVIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:08:09 -0400
Received: from gw.netgem.com ([195.68.2.34]:3082 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S264009AbTFBVH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:07:59 -0400
Subject: Re: [PATCH] radeonfb doesn't compile in 2.4.21-rc6
From: Jocelyn Mayer <jma@netgem.com>
To: James Mayer <james@cobaltmountain.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030602202444.GA9876@galileo>
References: <1054578295.4951.34.camel@jma1.dev.netgem.com>
	 <20030602202444.GA9876@galileo>
Content-Type: text/plain
Organization: 
Message-Id: <1054588182.4967.64.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 02 Jun 2003 23:09:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Please apologize: 
I checked the code and I finaly noticed
that this is a linuxPPC bug and that the buggy lines haven't
been reported in the main kernel tree.
So I will resend the patch to the LinuxPPC mainteners instead.

I promise I will check better before complaining, 
the next time I'll do :=)


On Mon, 2003-06-02 at 22:24, James Mayer wrote:
> On Mon, Jun 02, 2003 at 08:24:56PM +0200, Jocelyn Mayer wrote:
> > It seems to me that this was already reported for previous
> > 2.4.21-rc's, but never applied.
> > Here's the patch that make radeonfb compile (and work)
> > on my Ibook:
> >

> maybe it was never applied because you don't cc the 2.4 maintainer (Marcelo  
> Tosati)?
> 
> ciao, Marc

Ooops, I didn't post this patch before, but I think someone did.
That's the point I wanted to show...

> >
> > 19:06:04.0000
> > 00000 +0200
> > +++ linux-2.4.21-rc6-fixed/drivers/video/radeonfb.c    2003-06-01
> > 20:58:42.0000
> > 00000 +0200
> > @@ -1001,8 +1001,8 @@
> >         /* According to XFree86 4.2.0, some production M6's return 0
> >            for 8MB. */
> >         if (rinfo->video_ram == 0 &&
> > -           (pdev->device == PCI_DEVICE_ID_RADEON_LY ||
> > -            pdev->device == PCI_DEVICE_ID_RADEON_LZ)) {
> > +           (pdev->device == PCI_DEVICE_ID_ATI_RADEON_LY ||
> > +            pdev->device == PCI_DEVICE_ID_ATI_RADEON_LZ)) {
> >             rinfo->video_ram = 8192 * 1024;
> >           }
> 
> Hi,
> 
> I can't seem to find PCI_DEVICE_ID_ATI_RADEON_LY or
> PCI_DEVICE_ID_ATI_RADEON_LZ defined *anywhere* in 2.4.21-rc6, and the
> 2.4.21-rc6 version of radeonfb.c compiled just fine for me.
> 
>  - James

-- 
Jocelyn Mayer <jma@netgem.com>

