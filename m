Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUIBRIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUIBRIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268714AbUIBRIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:08:20 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:7308 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S267363AbUIBRIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:08:18 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Thu, 2 Sep 2004 19:10:57 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409021123.26299.ornati@fastwebnet.it> <200409022020.19062.adaplas@hotpop.com>
In-Reply-To: <200409022020.19062.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021910.58511.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 September 2004 14:20, Antonino A. Daplas wrote:
>
> Just to finalize everything, 2 more things:
>
> 1. Does changing the resolution affect the vyres upper limit?

I have tried with 640x480, 800x600 and 1024x768 and the upper limit seems 
the same (I've also tried some combinations of resolution / BPP)

>
> 2. What happens if you comment out banshee_wait_idle in tdfxfb_fillrect,
> tdfxfb_copyarea and tdfxfb_imageblit?  Scrolling should go faster but
> will removing it cause additional screen corruption?

scrolling is a bit faster and I don't notice any additional screen 
corruption

time cat MAINTAINERS (2.6.9-rc1 + your patch / 800x600 8bpp / YRES 3200)

normal: ~0.19
without banshee_wait_idle in the three functions: ~0.12 

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.8-gentoo-r3)
