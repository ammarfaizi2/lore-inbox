Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270642AbTHHJVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 05:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270880AbTHHJVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 05:21:04 -0400
Received: from smtp3.libero.it ([193.70.192.127]:16002 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S270642AbTHHJVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 05:21:02 -0400
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
From: Flameeyes <dgp85@users.sourceforge.net>
To: Pavel Machek <pavel@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LIRC list <lirc-list@lists.sourceforge.net>
In-Reply-To: <20030807214311.GC211@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin>
	 <20030807214311.GC211@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1060334463.5037.13.camel@defiant.flameeyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 08 Aug 2003 11:21:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 23:43, Pavel Machek wrote:
> If you want to get this applied to the official tree (I hope you want
> ;-), you probably should start with smaller patch. I killed all
> drivers but lirc_gpio, to make patch smaller/easier to check.
I sent to Alan Cox the "light" patch, but the "main" patch atm I think
it's best to remain the "full" one, for tests.

> * What does "For now don't try to use as static version" comment in
>   lirc_gpio mean. Does it only work as a module?
I'm not the author of the drivers, I only took them from the lirc cvs,
and make them compile under 2.5/6 series kernel.
AFAICS it should work also in-kernel, but I can't try because I can't
set bttv in-kernel, my card isn't autodetected. (Also, bttv author
suggest to don't compile bttv in-kernel, so depending on bttv, this
driver should be compiled as a module too).

> * This looks like it should be integrated with drivers/input. After
>   all remote control is just a strange keyboard. What are reasons that
>   can't be done?
This is a port of the drivers from lirc project (http://lirc.sf.net/),
I'm not going to rewrite it, also because the support for lirc in user
software is present in many programs, like xine, xawdecode, xmms (with
plugin) and so on.
The lirc_client library is simple and flexible, and the project is
consolidated, i don't see the need to change it, also because can be a
problem for backport in the 2.4 kernels.
-- 
Flameeyes <dgp85@users.sf.net>

