Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270490AbTG2CBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270931AbTG2CBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:01:00 -0400
Received: from dp.samba.org ([66.70.73.150]:30604 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270490AbTG2CA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:00:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rahul Karnik <rahul@genebrew.com>
Cc: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting. 
In-reply-to: Your message of "Mon, 28 Jul 2003 07:51:22 -0400."
             <3F250E3A.60305@genebrew.com> 
Date: Tue, 29 Jul 2003 09:13:55 +1000
Message-Id: <20030729020058.592C02C296@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3F250E3A.60305@genebrew.com> you write:
> Rusty Russell wrote:
> 
> > 	If module removal is to be a rare and unusual event, it
> > doesn't seem so sensible to go to great lengths in the code to handle
> > just that case.  In fact, it's easier to leave the module memory in
> > place, and not have the concept of parts of the kernel text (and some
> > types of kernel data) vanishing.
> 
> Rusty and others,
> 
> Module removal is *not* a rare event. One common case it is used is on 
> laptops during suspend.

Yes, but that cuts both ways: noone fixes these broken drivers, but
work around them using module removal, leaving newbies with broken
laptops 8(

> Last but not least weren't we moving towards a more modular kernel with 
> early userspace loading things from initrd as needed? Removing existing 
> module functionality, however broken it may be, seems to me a step 
> backward in this regard.

Not really.  Adding modules is required.  Removing them is a more
dubious goal, and if we didn't already have it, I know we'd balk at
doing it.

Hope that clarifies!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
