Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUIAUb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUIAUb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUIAUaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:30:12 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:60891 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267764AbUIAUUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:20:45 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Paolo Ornati <ornati@fastwebnet.it>, adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Thu, 2 Sep 2004 04:20:55 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409011851.00777.adaplas@hotpop.com> <200409011355.52999.ornati@fastwebnet.it>
In-Reply-To: <200409011355.52999.ornati@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409020420.55269.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 19:55, Paolo Ornati wrote:
> > Ok, I think I know why the scrolling speed is too slow, the driver is not
> > maximizing the extra memory of the framebuffer.
> >
> > This patch sets info->var.yres_virtual to the maximum upon driver load.
> > If this works, it's possible to get sub-1 second scrolling speed.
> >
> > Reverse the previous patch first, then apply this patch.
>
> Results for 2.6.9-rc1 + your patch (time cat MAINTAINERS):
>
> CONFIG_FB_3DFX_ACCEL=n
> ~1.27 s
>
> CONFIG_FB_3DFX_ACCEL=y
> ~0.18 s
>
> BUT with CONFIG_FB_3DFX_ACCEL enabled I get strange video
> "corruptions" (like bitmaps with random colors) that go away simply
> swithcing to another console and than back to the previous.

And another suggestion:

Try to comment out FBINFO_HWACCEL_COPYAREA.

Tony


