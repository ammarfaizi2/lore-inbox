Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUIALyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUIALyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbUIALyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:54:40 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:32714 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S266334AbUIALxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:53:20 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Wed, 1 Sep 2004 13:55:52 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409011821.06520.adaplas@hotpop.com> <200409011851.00777.adaplas@hotpop.com>
In-Reply-To: <200409011851.00777.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409011355.52999.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 12:51, Antonino A. Daplas wrote:
> On Wednesday 01 September 2004 18:21, Antonino A. Daplas wrote:
> > On Wednesday 01 September 2004 15:20, Paolo Ornati wrote:
> > > Ok, with this patch and CONFIG_FB_3DFX_ACCEL=y the scrolling speed
> > > comes back (only a bit slower than with 2.6.8.1 without
> > > CONFIG_FB_3DFX_ACCEL):
> > >
> > > $ time cat MAINTAINERS: ~2.67s
> >
> > Ok.  However, I'm still wondering at the scrolling speed, it's a bit
> > slower than what I would expect (I get < 1 second with vesafb which is
> > completely unaccelerated).
>
> Ok, I think I know why the scrolling speed is too slow, the driver is not
> maximizing the extra memory of the framebuffer.
>
> This patch sets info->var.yres_virtual to the maximum upon driver load.
> If this works, it's possible to get sub-1 second scrolling speed.
>
> Reverse the previous patch first, then apply this patch.

Results for 2.6.9-rc1 + your patch (time cat MAINTAINERS):

CONFIG_FB_3DFX_ACCEL=n
~1.27 s

CONFIG_FB_3DFX_ACCEL=y
~0.18 s

BUT with CONFIG_FB_3DFX_ACCEL enabled I get strange video 
"corruptions" (like bitmaps with random colors) that go away simply 
swithcing to another console and than back to the previous.

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.9-rc1)
