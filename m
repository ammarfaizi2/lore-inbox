Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264148AbUDRKFz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 06:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUDRKFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 06:05:54 -0400
Received: from ozlabs.org ([203.10.76.45]:51160 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264148AbUDRKFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 06:05:53 -0400
Subject: Re: [PATCH] Fix unix module
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040418090157.B4239@flint.arm.linux.org.uk>
References: <1082266361.14879.27.camel@bach>
	 <20040418090157.B4239@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1082282744.15014.33.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Apr 2004 20:05:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-18 at 18:01, Russell King wrote:
> On Sun, Apr 18, 2004 at 03:32:42PM +1000, Rusty Russell wrote:
> > The compiler #define's unix to 1: we use -DKBUILD_MODNAME=unix.  We
> > used to #undef unix at the top of af_unix.c, but now the name is
> > inserted by modpost, that doesn't help.
> 
> Do we depend on this preprocessor symbol anywhere?  If not, adding
> -Uunix to the global CFLAGS would prevent future "accidents".

I don't really mind which way it's done, but this was the direct
translation of the previous fix, so required less testing.

Hopefully noone will ever call their module "linux", "i386" or
"__OPTIMIZE__" 8)

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

