Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbVLJIoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbVLJIoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVLJIoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:44:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60946 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965075AbVLJIoe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:44:34 -0500
Date: Sat, 10 Dec 2005 08:44:22 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: gardner.ben@gmail.com, linux-kernel@vger.kernel.org,
       info-linux@ldcmail.amd.com
Subject: Re: [PATCH 1/3] i386: CS5535 chip support - cpu
Message-ID: <20051210084422.GC2833@ucw.cz>
References: <20051207194226.GA2617@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207194226.GA2617@cosmic.amd.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-12-05 12:42:26, Jordan Crouse wrote:
> +/* Note - this does not check to see if the CS5535 actually exists */
> +
> +#define LO(b)  (((1 << b) << 16) | 0x0000)
> +#define HI(b)  ((0x0000 << 16) | (1 << b))
> +

What kind of ninja mutant macros are these?

> +static u32 intab[16] __initdata = {
> +	0x20,HI(3), 0x24,LO(3), 0x28,LO(3),
> +	0x2C,LO(3), 0x34,HI(3), 0x38,LO(3),
> +     0x40,LO(3), 0x44,LO(3)
> +};

Can't you just use values here, without the macros?

							Pavel
-- 
Thanks, Sharp!
