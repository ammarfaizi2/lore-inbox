Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVJJSYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVJJSYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVJJSYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:24:12 -0400
Received: from mail.linicks.net ([217.204.244.146]:50695 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751155AbVJJSYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:24:11 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 CONFIG_INPUT_KEYBDEV
Date: Mon, 10 Oct 2005 19:24:02 +0100
User-Agent: KMail/1.8.1
References: <200510091141.10987.nick@linicks.net> <20051009204008.GG22601@alpha.home.local>
In-Reply-To: <20051009204008.GG22601@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510101924.02560.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 October 2005 21:40, Willy Tarreau wrote:

> > Oct  9 10:41:49 kernel: keyboard: Timeout - AT keyboard not present?(ed)
> > Oct  9 10:41:50 kernel: keyboard: Timeout - AT keyboard not present?(f4)
>
> (...)
>
> > Therefore I still have to manually edit include/linux/pc_keyb.h to undef
> > the (no) keyboard timeouts:
>
> This option is not used for pc_keyb.c inclusion which is linked unless you
> set CONFIG_DUMMY_KEYB (check drivers/char/Makefile for this), in which case
> you'll use dummy_keyb.c which was made exactly for your usage.

OK, thanks, but I am still confused.  I had to add CONFIG_DUMMY_KEYB=y 
manually (i386), as nowhere could I find an option in menuconfig (and 
find/grep revealed nothing either)...

This now boots with no keyboard warnings, as suggested (after I removed keymap 
etc. from start scripts).  But I still think I done it all wrong?

Nick
-- 
http://sourceforge.net/projects/quake2plus

"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

