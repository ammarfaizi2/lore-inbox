Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbTCTC1p>; Wed, 19 Mar 2003 21:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbTCTC1p>; Wed, 19 Mar 2003 21:27:45 -0500
Received: from ns.suse.de ([213.95.15.193]:28428 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261294AbTCTC1o>;
	Wed, 19 Mar 2003 21:27:44 -0500
Date: Thu, 20 Mar 2003 03:38:43 +0100
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
Message-ID: <20030320023843.GA22795@wotan.suse.de>
References: <20030320001013$67af@gated-at.bofh.it> <20030320001013$68b4@gated-at.bofh.it> <200303200136.h2K1aDsD001827@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303200136.h2K1aDsD001827@post.webmailer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 02:35:30AM +0100, Arnd Bergmann wrote:
> Why not simply move the common COMPATIBLE_IOCTLs and includes into
> kernel/compat_ioctl.c or similar? That would IMHO be cleaner and
> it does not need more preprocessing hacks.
> There can still be a second init_sys32_ioctl() copy to handle the arch
> specific list with additional translations.

This would work for COMPATIBLE_IOCTLS, but the conversions handlers
would need a new asm/ file for the macros. They're declared with assembler
magic to avoid declaring all the functions. This way you need less files.

-Andi
