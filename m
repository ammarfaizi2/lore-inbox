Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVCXH2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVCXH2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVCXH2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:28:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:51842 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262422AbVCXH2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:28:05 -0500
Date: Wed, 23 Mar 2005 23:25:51 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Frank Sorenson <frank@tuxrocks.com>, LKML <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 0/5] I8K driver facelift
Message-ID: <20050324072550.GL10604@kroah.com>
References: <200502240110.16521.dtor_core@ameritech.net> <4233B65A.4030302@tuxrocks.com> <4238A76A.3040408@tuxrocks.com> <200503170140.49328.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503170140.49328.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 01:40:48AM -0500, Dmitry Torokhov wrote:
> On Wednesday 16 March 2005 16:38, Frank Sorenson wrote:
> > Okay, I replaced the sysfs_ops with ops of my own, and now all the show
> > and store functions also accept the name of the attribute as a parameter.
> > This lets the functions know what attribute is being accessed, and allows
> > us to create attributes that share show and store functions, so things
> > don't need to be defined at compile time (I feel slightly evil!).
> 
> Hrm, can we be a little more explicit and not poke in the sysfs guts right
> in the driver? What do you think about the patch below athat implements
> "attribute arrays"? And I am attaching cumulative i8k patch using these
> arrays so they can be tested.
> 
> I am CC-ing Greg to see what he thinks about it.

Hm, I think it's proably of limited use, right?  What other code would
want this (the i2c sensor code doesn't, as it's naming scheme is
different.)

What drivers _do_ want is a way to create attributes on the fly easily,
and be able to have a "private" pointer to determine easier what file
was opened (to allow a single file handler, instead of the current
one-per-attribute type).

thanks,

greg k-h
