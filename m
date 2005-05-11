Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVEKGvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVEKGvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 02:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVEKGvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 02:51:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39692 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261902AbVEKGvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 02:51:14 -0400
Date: Wed, 11 May 2005 07:51:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Yani Ioannou <yani.ioannou@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4 1/3] dynamic sysfs callbacks
Message-ID: <20050511075100.A20000@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Yani Ioannou <yani.ioannou@gmail.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Jean Delvare <khali@linux-fr.org>,
	LM Sensors <sensors@stimpy.netroedge.com>,
	linux-kernel@vger.kernel.org
References: <253818670505070621784dbd63@mail.gmail.com> <20050510221615.GA4613@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050510221615.GA4613@kroah.com>; from greg@kroah.com on Tue, May 10, 2005 at 03:16:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 03:16:15PM -0700, Greg KH wrote:
> +#define __ATTR(_name,_mode,_show,_store) {	\
> +	.attr = {				\
> +		.name = __stringify(_name),	\
> +		.mode = _mode,			\
> +		.private = NULL,		\

We don't specifically initialise elements to NULL or zero.  Is this a
change of policy?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
