Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267440AbUH1JyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUH1JyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUH1JxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:53:15 -0400
Received: from eta.fastwebnet.it ([213.140.2.50]:61588 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S267403AbUH1Jrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:47:39 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.9-rc1-mm1 - undefined references - [PATCH]
Date: Sat, 28 Aug 2004 11:45:52 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <200408262053.08255.ornati@fastwebnet.it> <20040828085404.GW12772@fs.tum.de>
In-Reply-To: <20040828085404.GW12772@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408281145.52566.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 August 2004 10:54, Adrian Bunk wrote:
> 
> Your analysis is correct, but the following patch is a bit better since 
> it doesn't add a tdfxfb_lib:
> 
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> 
> --- linux-2.6.9-rc1-mm1-full/drivers/video/Makefile.old	2004-08-28 10:41:30.000000000 +0200
> +++ linux-2.6.9-rc1-mm1-full/drivers/video/Makefile	2004-08-28 10:46:20.000000000 +0200
> @@ -35,6 +35,9 @@
>  obj-$(CONFIG_FB_GBE)              += gbefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
>  obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
>  obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o
> +ifneq ($(CONFIG_FB_3DFX_ACCEL),y)
> +  obj-$(CONFIG_FB_3DFX)           += cfbfillrect.o cfbcopyarea.o
> +endif
>  obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
>  obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
>  obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o

I agree.
;-)

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.8-gentoo-r3)
