Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVCXV7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVCXV7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVCXV7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:59:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:55172 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261725AbVCXV7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:59:05 -0500
Date: Thu, 24 Mar 2005 13:58:51 -0800
From: cliff white <cliffw@osdl.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: drm bugs hopefully fixed but there might still be one..
Message-ID: <20050324135851.388d1b4e@es175>
In-Reply-To: <Pine.LNX.4.58.0503241015190.7647@skynet>
References: <Pine.LNX.4.58.0503241015190.7647@skynet>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 10:33:02 +0000 (GMT)
Dave Airlie <airlied@linux.ie> wrote:

> 
> Hi Andrew, Dave,
> 
> I've put a couple of patches into my drm-2.6 tree that hopefully fix up
> the multi-bridge on i915 and the XFree86 4.3 issue.. Andrew can you drop
> the two patches in your tree.. the one from Brice and the one I attached
> to the bug? you'll get conflicts anyway I'm sure. I had to modify Brices
> one as it didn't look safe to me in all cases..
> 
> I think their might be one left, but I think it only seems to be on
> non-intel AGP system, as in my system works fine for a combination of
> cards and X releases ... anyone with a VIA chipset and Radeon graphics
> card or r128 card.. testing the next -mm would help me a lot..

Okay, i have a iBook G4, with radeon, with 2.6.12-rc1-mm2, i'm getting the following OOPS
on boot. I'm hand-copying this stuff, please let me know if you need any more info, .config, etc
------------[drm] Initalized drm 1.0.0 20040925
floating point used in kernel (task=effc1770, pc=c03bd040)
Oops: kernel access of nad area, sig:11 [#1]
PREEMPT
NIP: C03BD040 LR: C01, cliffw80540 SP:
...
TASK = effc1770[1] 'swapper' THREAD: effc2000


LRL [c0180540] drm_agp_init+0x48/0xdc
Call trace:
 [c017e74c] drm_fill_in_dev+0xdc/0x180
 [c017eb44] drm_get_dev+0x78
 [c...] radeon_init
 [c...] do_initcalls
 [c..] init
 [c..] kernel_thread
---------------
cliffw

> 
> Dave.
> 
> -- 
> David Airlie, Software Engineer
> http://www.skynet.ie/~airlied / airlied at skynet.ie
> Linux kernel - DRI, VAX / pam_smb / ILUG
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
