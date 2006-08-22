Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWHVCWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWHVCWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 22:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWHVCWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 22:22:51 -0400
Received: from [198.99.130.12] ([198.99.130.12]:10908 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751143AbWHVCWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 22:22:51 -0400
Date: Mon, 21 Aug 2006 22:20:12 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
Message-ID: <20060822022012.GA7070@ccure.user-mode-linux.org>
References: <20060821215641.GQ11651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821215641.GQ11651@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 11:56:41PM +0200, Adrian Bunk wrote:
> arch/um/sys-i386/setjmp.S contains two #ifdef _REGPARM's.
> 
> Even if regparm was used in i386 uml (which isn't currently done (why?)),
> I don't see _REGPARM being defined anywhere.

setjmp.S was stolen from klibc, and I'd just as soon leave it alone and
not try to customize it for UML.  That file will disappear if/when klibc 
is in mainline, and I can just pull it in from usr.

In general, there's no reason that regparam can't be used for UML.  However,
in the past (I don't know if it's still a problem) gcc miscompiled regparam
code in the presence of -pg.

As for why it's not, I don't see any occurences of regparam in include/linux
or include/asm-i386 either.

> Is this a bug waiting for happening when regparm will be used on uml or 
> do I miss anything?

Probably not.

				Jeff
