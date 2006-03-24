Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWCXRvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWCXRvM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCXRvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:51:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:47528 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751316AbWCXRvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:51:11 -0500
Date: Fri, 24 Mar 2006 09:49:01 -0800
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Christopher Hoover <ch@murgatroid.com>, Andrew Morton <akpm@osdl.org>,
       kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [KJ] Re: [PATCH] Clean up magic numbers in i2c_parport.h
Message-ID: <20060324174901.GA27881@kroah.com>
References: <20060323205617.38e02afe.khali@linux-fr.org> <000e01c64efd$cae7f750$8401000a@fakie> <20060324082600.ca9f9796.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324082600.ca9f9796.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 08:26:00AM +0100, Jean Delvare wrote:
> Hi Christopher,
> 
> > > Beeuh. These macros don't really help. They actually make the lines
> > > longer! I'm not taking this change, sorry.
> > 
> > If I kill off the macros but continue to use C99 structure initializers,
> > which is I believe is the proper kernel coding style today, the lines are
> > going to get even longer.  Is that OK?
> > 
> > Or are you asking for the patch w/o macros and w/o C99 structure
> > initializers?
> > 
> > I can/will do either.  Just let me know what is acceptable a priori.
> 
> I don't think C99 initializers are needed here, the structure is pretty
> simple and is also defined in the same file, a few lines above all its
> instance declarations. So I am indeed asking for a patch w/o macros and
> w/o C99 structure initializers, unless someone objects.

You should use structure initializers whereever possible, as it makes
future changes much easier and safer (reorder the fields and things
don't break in odd ways.)  So I would encourage this kind of change.

thanks,

greg k-h
