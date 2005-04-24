Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVDXKpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVDXKpl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 06:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVDXKpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 06:45:41 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:22698 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262301AbVDXKp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 06:45:26 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: misc cleanups [4/4]
Date: Sun, 24 Apr 2005 12:30:27 +0200
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504232320.54477.rjw@sisk.pl> <200504232338.43297.rjw@sisk.pl> <20050423220757.GD1884@elf.ucw.cz>
In-Reply-To: <20050423220757.GD1884@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504241230.27544.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 24 of April 2005 00:07, Pavel Machek wrote:
> Hi!
> 
> > The following patch makes some comments and printk()s in swsusp.c up to date.
> > In particular it adds the string "swsusp" before every message that is printed by
> > the code in swsusp.c.
> 
> I don't like this one. Adding swsusp everywhere just clutters the
> screen, most of it should be clear from context.

Right.  Still, I'd like to drop function names from debug messages
and replace "suspend" with "swsusp" in some messages.  I'll send another
patch for it after 2.6.12 (please let me know if you don't think it's a good
idea ;-)).

For now, please drop the patch altogether.

> > @@ -1226,9 +1222,6 @@ static int check_sig(void)
> >  
> >  /**
> >   *	data_read - Read image pages from swap.
> > - *
> > - *	You do not need to check for overlaps, check_pagedir()
> > - *	already did that.
> >   */
> >  
> >  static int data_read(struct pbe *pblist)
> 
> Why is this comment no longer valid?

It's just confusing.  Initially, I didn't intend to change it, but then I read it
and thought "What overlaps?".  In data_read() there's nothing that could
overlap with anything else ...

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
