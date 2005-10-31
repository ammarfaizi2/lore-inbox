Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVJaXQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVJaXQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVJaXQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:16:27 -0500
Received: from waste.org ([216.27.176.166]:48519 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964864AbVJaXQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:16:26 -0500
Date: Mon, 31 Oct 2005 15:11:21 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 17/20] inflate: mark some arrays as initdata
Message-ID: <20051031231120.GF4367@waste.org>
References: <17.196662837@selenic.com> <18.196662837@selenic.com> <20051031224301.GF20452@flint.arm.linux.org.uk> <20051031225746.GD4367@waste.org> <20051031231052.GA1710@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031231052.GA1710@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 11:10:52PM +0000, Russell King wrote:
> That's what threading is for. 8)

What's what's threading is for?

> > I think for ARM, we can simply do -DINITDATA=const, yes?
> 
> No, unless you want to make this const:
> 
> -static u8 window[0x8000]; /* use a statically allocated window */
> +static u8 INITDATA window[0x8000]; /* use a statically allocated window */

Ok, that bit can just be dropped. It needn't be INITDATA anyway, as it
now gets kmalloc'ed for users in the kernel proper. Anything else?

-- 
Mathematics is the supreme nostalgia of our time.
