Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVAXCus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVAXCus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 21:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVAXCus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 21:50:48 -0500
Received: from waste.org ([216.27.176.166]:33218 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261424AbVAXCul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 21:50:41 -0500
Date: Sun, 23 Jan 2005 18:50:34 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] core-small: Introduce CONFIG_CORE_SMALL from -tiny
Message-ID: <20050124025034.GW12076@waste.org>
References: <1.464233479@selenic.com> <20050123004042.09f7f8eb.akpm@osdl.org> <20050123175204.GV12076@waste.org> <20050123130514.0a9656bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123130514.0a9656bb.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 01:05:14PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > > I wish it didn't have "core" in the name.  A little misleading.
> > 
> >  Well I've got another set called NET_SMALL. BASE?
> 
> BASE works, I guess.
> 
> >  > #define PID_MAX_DEFAULT (CONFIG_CORE_SMALL ? 0x1000 : 0x8000)
> >  > #define UIDHASH_BITS (CONFIG_CORE_SMALL ? 3 : 8)
> >  > #define FUTEX_HASHBITS (CONFIG_CORE_SMALL ? 4 : 8)
> >  > etc.
> > 
> >  Hmm. I think we'd want a hidden config variable for this and I'm not
> >  sure how well the config language allows setting an int from a bool.
> 
> config AKPM_BOOL
>         bool "akpm"
> 
> config AKPM_INT
>         int
>         default 1 if AKPM_BOOL
>         default 0 if !AKPM_BOOL
> 
> seems to do everything which it should.
> 
> >  And then it would need another name. On the whole, seems more complex
> >  than what I've done.
> 
> No, it's quite simple and avoids lots of ifdeffing.

Ok, will respin these Monday.

-- 
Mathematics is the supreme nostalgia of our time.
