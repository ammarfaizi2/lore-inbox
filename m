Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVJIUlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVJIUlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 16:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVJIUlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 16:41:11 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:43527 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750815AbVJIUlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 16:41:11 -0400
Date: Sun, 9 Oct 2005 22:40:08 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 CONFIG_INPUT_KEYBDEV
Message-ID: <20051009204008.GG22601@alpha.home.local>
References: <200510091141.10987.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510091141.10987.nick@linicks.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 11:41:10AM +0100, Nick Warne wrote:
> What exactly does CONFIG_INPUT_KEYBDEV do?

It's used to link keybdev.o in drivers/input/Makefile, and to resolve a
few dependencies for other config options (HIL) in some hil/Config.in.

> I found that _not_setting it, 2.4.31 still looks for keyboard at boot:
> 
> Oct  9 10:41:49 kernel: keyboard: Timeout - AT keyboard not present?(ed)
> Oct  9 10:41:50 kernel: keyboard: Timeout - AT keyboard not present?(f4)

(...)

> Therefore I still have to manually edit include/linux/pc_keyb.h to undef the 
> (no) keyboard timeouts:

This option is not used for pc_keyb.c inclusion which is linked unless you
set CONFIG_DUMMY_KEYB (check drivers/char/Makefile for this), in which case
you'll use dummy_keyb.c which was made exactly for your usage.

Cheers,
Willy

