Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131172AbRBVWl4>; Thu, 22 Feb 2001 17:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131282AbRBVWlh>; Thu, 22 Feb 2001 17:41:37 -0500
Received: from vitelus.com ([64.81.36.147]:7431 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S131120AbRBVWl3>;
	Thu, 22 Feb 2001 17:41:29 -0500
Date: Thu, 22 Feb 2001 14:41:22 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Better BUG() macro - take 2
Message-ID: <20010222144122.A32257@vitelus.com>
In-Reply-To: <3A924B83.43133ED2@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A924B83.43133ED2@yahoo.com>; from p_gortmaker@yahoo.com on Tue, Feb 20, 2001 at 05:48:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 05:48:35AM -0500, Paul Gortmaker wrote:
> Ok, it appears that some people want the __FILE__, __LINE__ (or equivalent)
> in BUG() and some don't.  Fair enough.  I used the existing config option
> CONFIG_DEBUG_ERRORS to allow people to choose.  There was also interest
> in having BUG() in a more sensible place (e.g. <linux/kernel.h>) and the
> arch specific part separate (I picked <asm-xxx/system.h>).
> 
> This only deals with i386 - wanted to put this out for comment before
> editing for the others.  Change for other arch is simple though - just
> remove BUG() from asm/page.h and put the *(int *)0=0; type part of what
> was BUG() into asm/system.h as machine_bug(). Oh, and add the config
> option to arch/*/config.in if it isn't already in use.

I noticed the wasteful strings in the kernel image recently and am
excited about this patch.

However, shouldn't this be fixed for all architectures?

Once that happens and the EXPORT_SYMBOL is #ifdef'd, I hope you submit
this to Alan.
