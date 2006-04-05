Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWDEVjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWDEVjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDEVjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:39:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38380 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751081AbWDEVjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:39:22 -0400
From: Andreas Schwab <schwab@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Zou Nan hai <nanhai.zou@intel.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: 2.6.17-rc1-mm1
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404233851.GA6411@agluck-lia64.sc.intel.com>
	<1144202706.3197.11.camel@linux-znh>
	<200604051015.34217.bjorn.helgaas@hp.com>
	<20060405211757.GA8536@agluck-lia64.sc.intel.com>
X-Yow: Disco oil bussing will create a throbbing naugahide pipeline running
 straight to the tropics from the rug producing regions
 and devalue the dollar!
Date: Wed, 05 Apr 2006 23:39:16 +0200
In-Reply-To: <20060405211757.GA8536@agluck-lia64.sc.intel.com> (Tony Luck's
	message of "Wed, 5 Apr 2006 14:17:57 -0700")
Message-ID: <jer74b7ldn.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index d5a04b6..4ca9877 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -484,8 +484,8 @@ #endif
>  	}
>  
>  	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
> -	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
> -	vga_vram_size = vga_vram_end - vga_vram_base;
> +	vga_vram_end = VGA_MAP_MEM(vga_vram_end - 1);
> +	vga_vram_size = vga_vram_end - vga_vram_base + 1;

Better use vga_vram_end = VGA_MAP_MEM(vga_vram_end - 1) + 1, or you'll
screw up the other computations using vga_vram_end.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
