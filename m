Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUCBPdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUCBPdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:33:00 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:21463 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261673AbUCBPc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:32:56 -0500
Date: Tue, 2 Mar 2004 08:32:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb: fix kgdbeth compilation and make it init late enough
Message-ID: <20040302153250.GE16434@smtp.west.cox.net>
References: <20040302112500.GA485@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302112500.GA485@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 12:25:00PM +0100, Pavel Machek wrote:

> Hi!
> 
> CONFIG_NO_KGDB_CPUS can not be found anywhere in the patches => its
> probably not needd any more.

I don't know if we can do that.  There's some funky locking stuff done
on SMP, which for some reason can't be done to NR_CPUS (or, no one has
tried doing that).

> init_kgdboe can't be module_initcall; in
> such cases it initializes after tg3 network card (and that's bad).

Ah, that's an even better fix than trying to enforce link order.

> Okay to commit?

Second half, yes.

-- 
Tom Rini
http://gate.crashing.org/~trini/
