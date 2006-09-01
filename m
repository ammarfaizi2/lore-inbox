Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWIAAQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWIAAQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 20:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWIAAQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 20:16:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964827AbWIAAQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 20:16:25 -0400
Date: Thu, 31 Aug 2006 17:16:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp with PAE
Message-Id: <20060831171615.6a420025.akpm@osdl.org>
In-Reply-To: <20060831160546.3309d745.rdunlap@xenotime.net>
References: <20060831135336.GL3923@elf.ucw.cz>
	<20060831104304.e3514401.akpm@osdl.org>
	<20060831223521.GB31125@elf.ucw.cz>
	<20060831154828.4313327c.akpm@osdl.org>
	<20060831225232.GE31125@elf.ucw.cz>
	<20060831160546.3309d745.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 16:05:46 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> > > I think what this really points at is a weakness in the menuconfig/xconfig/etc
> > > user interfaces.  It should be possible to navigate to the presently-disabled
> > > config option and ask it "why can't I turn you on?".
> > 
> > Yes, but I'll still have users asking me "why I can't turn it on" ;-).
> 
> menuconfig and xconfig both have Help and Search that can aid
> with that, but I would still use the "comment" keyword also.

Help and Search options aren't much use if you cannot see the option and if
you do not know that it exists.

A better UI design would be to show the unselectable option in some
dimmed-out fashion and then provide an interface which permits the user to

a) query the item to find out why it's not selectable and

b) turn on the depends-on option(s) at the present site, thus making the
   present item selectable (ie: not dimmed any more).

I dont't think any of that would require any Kconfig changes - it's purely
a UI thing?
