Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWBMV2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWBMV2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWBMV2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:28:21 -0500
Received: from ns.suse.de ([195.135.220.2]:12954 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030196AbWBMV2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:28:20 -0500
From: Andreas Schwab <schwab@suse.de>
To: hawkes@sgi.com
Cc: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>, Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH] ia64: simplify and fix udelay()
References: <20060213183344.21339.33094.sendpatchset@tomahawk.engr.sgi.com>
X-Yow: ..  I don't understand the HUMOR of the THREE STOOGES!!
Date: Mon, 13 Feb 2006 22:28:18 +0100
In-Reply-To: <20060213183344.21339.33094.sendpatchset@tomahawk.engr.sgi.com>
	(hawkes@sgi.com's message of "Mon, 13 Feb 2006 10:33:44 -0800")
Message-ID: <jefymnaqz1.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hawkes@sgi.com writes:

> Index: linux/arch/ia64/sn/kernel/sn2/timer.c
> ===================================================================
> --- linux.orig/arch/ia64/sn/kernel/sn2/timer.c	2006-02-08 17:59:42.000000000 -0800
> +++ linux/arch/ia64/sn/kernel/sn2/timer.c	2006-02-09 09:02:31.000000000 -0800
> @@ -28,9 +28,29 @@ static struct time_interpolator sn2_inte
>  	.source = TIME_SOURCE_MMIO64
>  };
>  
> +extern void (*ia64_udelay)(unsigned long usecs);

Please put the declaration in a header.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
