Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270538AbRHNKo7>; Tue, 14 Aug 2001 06:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270539AbRHNKou>; Tue, 14 Aug 2001 06:44:50 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:61362 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S270538AbRHNKoj>; Tue, 14 Aug 2001 06:44:39 -0400
Date: Tue, 14 Aug 2001 11:44:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rich Baum <richbaum@acm.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] fix 2.4.8 compile errors
Message-ID: <20010814114446.A23566@flint.arm.linux.org.uk>
In-Reply-To: <100C620A6B75@coral.indstate.edu> <1013D72A35C6@coral.indstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1013D72A35C6@coral.indstate.edu>; from richbaum@acm.org on Tue, Aug 14, 2001 at 05:32:16AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 05:32:16AM -0500, Rich Baum wrote:
> Thanks for the input.  I've fixed this patch to include the fis.

You missed the one below.

> diff -urN -X dontdiff linux-2.4.8/drivers/video/Config.in rb/drivers/video/Config.in
> --- linux-2.4.8/drivers/video/Config.in	Sat Aug 11 11:10:30 2001
> +++ rb/drivers/video/Config.in	Mon Aug 13 20:43:46 2001
> @@ -103,7 +103,8 @@
>     fi
>     tristate '  NEC PowerVR 2 display support' CONFIG_FB_PVR2
>     dep_bool '    Debug pvr2fb' CONFIG_FB_PVR2_DEBUG $CONFIG_FB_PVR2
> -   bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
> +   if [ "$ARCH" = "sh" ]; then
> +      bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
>     if [ "$CONFIG_FB_E1355" = "y" ]; then
>        hex '    Register Base Address' CONFIG_E1355_REG_BASE a8000000
>        hex '    Framebuffer Base Address' CONFIG_E1355_FB_BASE a8200000

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

