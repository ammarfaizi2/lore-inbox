Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVBAKQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVBAKQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 05:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVBAKQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 05:16:25 -0500
Received: from mproxy.gmail.com ([216.239.56.244]:31849 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261958AbVBAKQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 05:16:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pSVO9r07uuMMlSn4lAodjNgx2baLNkqVIKCoewtWb9hMxMLhWZSvdxojWEpvMqh+6LoGB/mxqogf+75/WmRo0D+KMHAN0IKek9MQtFJjFFS+NFzMGIYO2Jhz0qEZ0wOLEpXM6EqLjD46J+s2/SkLVfaYbqJtjunyCo2S54quepA=
Message-ID: <21d7e99705020102164f62da2d@mail.gmail.com>
Date: Tue, 1 Feb 2005 21:16:16 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] DRM: misc cleanup
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050131003650.GB7103@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050131003650.GB7103@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 01:36:50 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains the following cleanups:
> - make needlessly global functions static
> - remove the following unused global functions:
>   - drm_fops.c: drm_read
>   - i810_dma.c: i810_do_cleanup_pageflip
>   - i830_dma.c: i830_do_cleanup_pageflip
>   - i915_dma.c: i915_do_cleanup_pageflip
>   - mga_dma.c: mga_do_dma_idle
>   - mga_dma.c: mga_do_engine_reset
>   - radeon_irq.c: radeon_emit_and_wait_irq
>   - sis_ds.c: mmAddRange
>   - sis_ds.c: mmReserveMem
>   - sis_ds.c: mmFreeReserved
>   - sis_ds.c: mmDestroy
>   - via_ds.c: via_mmDumpMemInfo
>   - via_ds.c: via_mmAddRange
>   - via_ds.c: via_mmReserveMem
>   - via_ds.c: via_mmFreeReserved
>   - via_ds.c: via_mmDestroy
> - remove the followig unused global variable:
>   - via_mm.c: VIA_DEBUG

I'll nack this patch for now Adrian, but I'm going to bring all these
changes into the DRM tree as soon as I can.. one of the functions you
removed pointed out a bug in the i810/i830/i915 drivers (granted
no-one uses pageflip in those drivers but still should fix it..), I'm
going to put the through drm CVS first...

Thanks,
Dave.
