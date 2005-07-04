Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVGDFpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVGDFpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 01:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVGDFpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 01:45:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:2964 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261440AbVGDFou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 01:44:50 -0400
Date: Sun, 3 Jul 2005 22:44:41 -0700
From: Greg KH <greg@kroah.com>
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A "new driver model" and EXPORT_SYMBOL_GPL question
Message-ID: <20050704054441.GA19936@kroah.com>
References: <20050703171202.A7210@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050703171202.A7210@mail.harddata.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 05:12:02PM -0600, Michal Jaegermann wrote:
> It dawned on me only now that a "new driver model" introduced
> in patches from GKH export symbols like that:
> 
> EXPORT_SYMBOL_GPL(class_create);
> EXPORT_SYMBOL_GPL(class_destroy);
> 
> and so on.  The problem is that corresponding old symbols, which
> are still present in 2.6.12, were exported
> 
> EXPORT_SYMBOL(class_simple_create);
> EXPORT_SYMBOL(class_simple_destroy);
> ....
> 
> This creates a problem.  There exist out-of-tree drivers which are
> using those symbols

Where?  What drivers?

> and, even if sources are available, are not
> licensed GPL for whatever reasons.  No, I am not the author of any
> of those so I cannot do very much about re-licensing.  As an effect
> a conversion to a "new driver model", even if simple, does not work.
> In particular I bumped into that with Myrinet card drivers.

Then take it up with them.  Users of those symbols have had many months
advance notice that this was going to happen.

> Was a decision to use EXPORT_SYMBOL_GPL deliberate and if yes then
> what considerations dictated it, other then the patch author wrote
> it that way, and what drivers in question are supposed to use when
> this change will show up in the mainline?  It looks that 2.6.13
> will do this.

Please see the archives for the answers to these questions.

thanks,

greg k-h
