Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbVJGVWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbVJGVWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 17:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbVJGVWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 17:22:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53905 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932667AbVJGVWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 17:22:18 -0400
Date: Fri, 7 Oct 2005 16:46:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Etienne Lorrain <etienne.lorrain@masroudeau.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Gujin linux.kgz boot format
Message-ID: <20051007144631.GA1294@elf.ucw.cz>
References: <2031.192.168.201.6.1128591983.squirrel@pc300>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2031.192.168.201.6.1128591983.squirrel@pc300>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  It perfectly works for me, and even after reading those tens of times
> I no more find anything to change or improve.
>  Can someone propose a way forward, either in the direction of
> linux-2.6.14/15 or in the -mm tree, and/or propose improvement or
> point me to my bug(s) ?

And advantages are? Having to maintain both C and assembly version
does not seem like improvement to me.

> +#define STR static const char

Ouch.
								Pavel
 +const unsigned maskvesa = 0

> +#ifndef CONFIG_FB_VESA
> +	| (1 << 0)	/* Cannot boot in MASKVESA_1BPP */
> +	| (1 << 1)	/* Cannot boot in MASKVESA_2BPP */
> +	| (1 << 3)	/* Cannot boot in MASKVESA_4BPP */
> +	| (1 << 7)	/* Cannot boot in MASKVESA_8BPP */
> +	| (1 << 14)	/* Cannot boot in MASKVESA_15BPP */
> +	| (1 << 15)	/* Cannot boot in MASKVESA_16BPP */
> +	| (1 << 23)	/* Cannot boot in MASKVESA_24BPP */
> +	| (1 << 31)	/* Cannot boot in MASKVESA_32BPP */
> +#endif
> +#if defined (CONFIG_VGA_CONSOLE) || defined (CONFIG_MDA_CONSOLE)
> +	| (1 << 16)	/* able to boot in text mode */
> +#endif
> +	// | (1 << 17)	/* not able to boot in VESA1 mode */
> +#ifdef CONFIG_FB_VESA
> +	| (1 << 18)	/* able to boot in VESA2 linear mode */
> +#endif
> +	// | (1 << 19)	/* force VESA1 if in VESA2 */
> +	| (1 << 20)	/* Cannot handle VGA graphic modes */
> +	;


-- 
if you have sharp zaurus hardware you don't need... you know my address
