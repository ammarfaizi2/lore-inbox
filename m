Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVCUWy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVCUWy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVCUWyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:54:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:44751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262130AbVCUWxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:53:15 -0500
Date: Mon, 21 Mar 2005 14:53:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: covici@ccs.covici.com
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@linux.ie>
Subject: Re: X not working with Radeon 9200 under 2.6.11
Message-Id: <20050321145301.3511c097.akpm@osdl.org>
In-Reply-To: <16937.54786.986183.491118@ccs.covici.com>
References: <16937.54786.986183.491118@ccs.covici.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John covici <covici@ccs.covici.com> wrote:
>
> Hi.  I Have a Radeon 9200c and ever since some time in the 2.6.9
> series, I cannot get X to start using this card.  It dies in such a
> way that there is no way to get the vga console out of that console
> and chvt from another terminal just hangs and xinit cannot be
> cancelled.

John, it would be useful if you could test 2.6.12-rc1-mm1, which has a few
fixes in this area.

Would it be correct to assume that you are not using either of the radeon
fbdev drivers?

And are you using the kernel's DRI drivers?

Thanks.

> This is the lspci for the agp card.
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280
> [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
>      Subsystem: PC Partner Limited: Unknown device 7c26
>      Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
>      Memory at e8000000 (32-bit, prefetchable) [size=128M]
>      I/O ports at e000 [size=256]
>      Memory at fbe00000 (32-bit, non-prefetchable) [size=64K]
>      Expansion ROM at fbd00000 [disabled] [size=128K]
>      Capabilities: [58] AGP version 3.0
>      Capabilities: [50] Power Management version 2
> 
> 0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon
> 9200 SE] (Secondary) (rev 01)
>      Subsystem: PC Partner Limited: Unknown device 7c27
>      Flags: bus master, 66MHz, medium devsel, latency 64
>      Memory at f0000000 (32-bit, prefetchable) [size=128M]
>      Memory at fbf00000 (32-bit, non-prefetchable) [size=64K]
>      Capabilities: [50] Power Management version 2
> 
> Any assistance would be appreciated.
> 
> -- 
> Your life is like a penny -- how are you going to spend it?
> 
>          John Covici
>          covici@ccs.covici.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
