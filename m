Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVBONKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVBONKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVBONKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:10:16 -0500
Received: from styx.suse.cz ([82.119.242.94]:54152 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261712AbVBONKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:10:10 -0500
Date: Tue, 15 Feb 2005 14:10:52 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, ncunningham@cyclades.com,
       bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix u32 vs. pm_message_t in i8042.c
Message-ID: <20050215131052.GB7250@ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org> <20050215005557.GH5415@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215005557.GH5415@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 01:55:57AM +0100, Pavel Machek wrote:
> Hi!
> 
> This fixes u32 vs. pm_message_t in i8042.c. Please apply,

I have this change in my tree already.

> 								Pavel
> 
> --- clean-mm/drivers/input/serio/i8042.c	2005-02-15 00:46:40.000000000 +0100
> +++ linux-mm/drivers/input/serio/i8042.c	2005-02-15 01:04:10.000000000 +0100
> @@ -900,7 +900,7 @@
>   * Here we try to restore the original BIOS settings
>   */
>  
> -static int i8042_suspend(struct device *dev, u32 state, u32 level)
> +static int i8042_suspend(struct device *dev, pm_message_t state, u32 level)
>  {
>  	if (level == SUSPEND_DISABLE) {
>  		del_timer_sync(&i8042_timer);
> 
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
