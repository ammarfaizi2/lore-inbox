Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUCKOy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUCKOw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:52:58 -0500
Received: from zero.aec.at ([193.170.194.10]:34822 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261399AbUCKOvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:51:39 -0500
To: Bart Oldeman <bartoldeman@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] introduce a mmap MAP_DONTEXPAND flag
References: <1yz3a-k2-33@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 18 Mar 2004 01:58:02 +0100
In-Reply-To: <1yz3a-k2-33@gated-at.bofh.it> (Bart Oldeman's message of "Thu,
 11 Mar 2004 15:10:25 +0100")
Message-ID: <m3d67bas4l.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Oldeman <bartoldeman@users.sourceforge.net> writes:

>  			return -EPERM;
> --- include/asm-i386/mman.h~	Sat Oct 25 19:42:58 2003
> +++ include/asm-i386/mman.h	Thu Mar 11 13:37:33 2004
> @@ -22,6 +22,7 @@
>  #define MAP_NORESERVE	0x4000		/* don't check for reservations */
>  #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
>  #define MAP_NONBLOCK	0x10000		/* do not block on IO */
> +#define MAP_DONTEXPAND	0x20000		/* do not allow mremap to expand */

*always* when you change something in asm-i386 check if other architectures
need changing too. Your patch would break compilation for everybody !i386

-Andi

