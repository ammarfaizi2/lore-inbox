Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268908AbTGJDpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268909AbTGJDpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:45:17 -0400
Received: from storm.he.net ([64.71.150.66]:38582 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S268908AbTGJDpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:45:14 -0400
Date: Wed, 9 Jul 2003 20:56:11 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] timer clean up for i2c-keywest.c
Message-ID: <20030710035611.GD1561@kroah.com>
References: <16137.6948.764603.59450@cargo.ozlabs.ibm.com> <1057659989.11708.113.camel@gaston> <1057744088.506.8.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057744088.506.8.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 11:48:08AM +0200, Benjamin Herrenschmidt wrote:
> On Tue, 2003-07-08 at 12:26, Benjamin Herrenschmidt wrote:
> > On Mon, 2003-07-07 at 09:03, Paul Mackerras wrote:
> > > This patch changes i2c-keywest.c to use mod_timer instead of a
> > > two-line sequence to compute .expires and call add_timer in 3 places.
> > > Without this patch I get a BUG from time to time in add_timer.
> > 
> > Ok, here it is. It also remove the never used "polled" mode. The
> > driver is now in sync with the more up-to-date 2.4 version ;)
> > 
> > Sorry for not sending that earlier, I forgot about it and didn't
> > notice it was out of sync.
> 
> And just in case you didn't merge it yet... Here's a version changing
> the timer->expire ; add_timer() pairs into calls to mod_timer, makes
> the code slighly cleaner.

Thanks, I've applied this one.

greg k-h
