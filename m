Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVEKHFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVEKHFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVEKHFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:05:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:13753 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261903AbVEKHFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:05:43 -0400
Date: Wed, 11 May 2005 00:05:34 -0700
From: Greg KH <greg@kroah.com>
To: Yani Ioannou <yani.ioannou@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4 1/3] dynamic sysfs callbacks
Message-ID: <20050511070534.GA10194@kroah.com>
References: <253818670505070621784dbd63@mail.gmail.com> <20050510221615.GA4613@kroah.com> <20050511075100.A20000@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511075100.A20000@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 07:51:00AM +0100, Russell King wrote:
> On Tue, May 10, 2005 at 03:16:15PM -0700, Greg KH wrote:
> > +#define __ATTR(_name,_mode,_show,_store) {	\
> > +	.attr = {				\
> > +		.name = __stringify(_name),	\
> > +		.mode = _mode,			\
> > +		.private = NULL,		\
> 
> We don't specifically initialise elements to NULL or zero.  Is this a
> change of policy?

Doh, no, it isn't, you are correct.  I've updated the patch, removing
the changes to the __ATTR() and other macro that I modified.

Thanks for catching this.

greg k-h
