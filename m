Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbTLZXXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbTLZXXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:23:42 -0500
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:45696 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265259AbTLZXWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:22:49 -0500
Date: Fri, 26 Dec 2003 22:19:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: niraj gupta <niraj_gupta@qosmetrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 0n the heels on 10khz patch for 2.6 here is the patch for 2.4 hot of the press
Message-ID: <20031226211956.GA197@elf.ucw.cz>
References: <200312151808.04337.niraj_gupta@qosmetrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312151808.04337.niraj_gupta@qosmetrix.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> just wanted to thank Jean-Marc Valin for the 10khz patch, 
> here is the patch for 2.4, it boots for me for 2.4G HT/SMP enabled CPU
> but YMMV
> 
> i am not subscribed to the list so please cc me personally
> if it were not for kerneltrap i would have never seen the original
> patch

First, it is preferable to inline patches.

> diff -urN linux-2.4.22/arch/i386/kernel/apic.c 10klinux-2.4.22/arch/i386/kernel/apic.c
> --- linux-2.4.22/arch/i386/kernel/apic.c	2003-06-13 07:51:29.000000000 -0700
> +++ 10klinux-2.4.22/arch/i386/kernel/apic.c	2003-12-15 17:55:37.000000000 -0800
> @@ -767,7 +767,7 @@
>  	 * chipset timer can cause.
>  	 */
>  
> -	} while (delta < 300);
> +	} while (delta < 30);
>  }
>  
>  /*


Second, I'm not sure how good idea this is. Others are bugfixes, but
this has ability to break stuff.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
