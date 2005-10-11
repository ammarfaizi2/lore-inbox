Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVJKEuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVJKEuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVJKEuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:50:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:52743 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751356AbVJKEuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:50:05 -0400
Date: Tue, 11 Oct 2005 06:50:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 CONFIG_INPUT_KEYBDEV
Message-ID: <20051011045001.GH22601@alpha.home.local>
References: <200510091141.10987.nick@linicks.net> <20051009204008.GG22601@alpha.home.local> <200510101924.02560.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510101924.02560.nick@linicks.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 07:24:02PM +0100, Nick Warne wrote:
> On Sunday 09 October 2005 21:40, Willy Tarreau wrote:
> 
> > > Oct  9 10:41:49 kernel: keyboard: Timeout - AT keyboard not present?(ed)
> > > Oct  9 10:41:50 kernel: keyboard: Timeout - AT keyboard not present?(f4)
> >
> > (...)
> >
> > > Therefore I still have to manually edit include/linux/pc_keyb.h to undef
> > > the (no) keyboard timeouts:
> >
> > This option is not used for pc_keyb.c inclusion which is linked unless you
> > set CONFIG_DUMMY_KEYB (check drivers/char/Makefile for this), in which case
> > you'll use dummy_keyb.c which was made exactly for your usage.
> 
> OK, thanks, but I am still confused.  I had to add CONFIG_DUMMY_KEYB=y 
> manually (i386), as nowhere could I find an option in menuconfig (and 
> find/grep revealed nothing either)...
> 
> This now boots with no keyboard warnings, as suggested (after I removed keymap 
> etc. from start scripts).  But I still think I done it all wrong?

Not necessarily, it may be that too few people use it and the option has
vanished from any config. You can provide a patch to re-enable it if you
want. In this case, please also provide a little help in Configure.help.

Regards,
Willy

