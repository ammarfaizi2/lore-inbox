Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267671AbUIAUK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267671AbUIAUK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267670AbUIAUKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:10:23 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:13956 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267628AbUIAUKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:10:00 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Paolo Ornati <ornati@fastwebnet.it>, adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Thu, 2 Sep 2004 04:10:22 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409011851.00777.adaplas@hotpop.com> <200409011355.52999.ornati@fastwebnet.it>
In-Reply-To: <200409011355.52999.ornati@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409020410.22617.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 19:55, Paolo Ornati wrote:
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

Might be a clipping problem?  Maybe we need to set an upper limit
to vyres, don't know for sure.  

Try doing an fbset -vyres 800, then keep doubling the number until
you get the artifacts.  If possible, do it for other bpp.

Tony 


