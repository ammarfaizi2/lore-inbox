Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVJEUwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVJEUwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVJEUwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:52:47 -0400
Received: from [203.171.93.254] ([203.171.93.254]:7849 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1750832AbVJEUwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:52:46 -0400
Subject: Re: [PATCH] Free swap suspend from depending upon PageReserved.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200510051454.56096.rjw@sisk.pl>
References: <1128506536.5514.13.camel@localhost>
	 <20051005121222.GA22580@elf.ucw.cz>  <200510051454.56096.rjw@sisk.pl>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128544625.10363.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 06 Oct 2005 06:37:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-10-05 at 22:54, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wednesday, 5 of October 2005 14:12, Pavel Machek wrote:
> > Hi!
> > 
> > > Here's the patch we've previously discussed, which removes the
> > > dependancy of swap suspend on PageReserved.
> > 
> > This ends up in Linus' changelog, so "we've previously discussed"
> > is not okay here. Missing signed-off. What is benefit of this?
> > 
> > swsusp part looks okay, but will Andrew like the generic part? I guess
> > I'd prefer to postpone this one (unless we are last user of
> > PageReserved) -- I do not see too big benefit and there's potential
> > for breakage.
> 
> Basically, what it does is to make swsusp avoid saving (and restoring)
> non-RAM pages (like the ISA hole, BIOS etc.).  I think it is a nice thing
> to do and it does not hurt anyone (it only clears and/or sets PG_nosave
> at some places).  However, if we decide to do this for i386, it should
> also be done for x86-64.

True. I wasn't thinking about others arches, and should have. I'll
modify the patch and seek to repost today.

Regards,

Nigel

> Greetings,
> Rafael
-- 


