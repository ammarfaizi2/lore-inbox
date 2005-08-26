Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVHZTjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVHZTjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVHZTjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:39:04 -0400
Received: from peabody.ximian.com ([130.57.169.10]:28862 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1030228AbVHZTjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:39:02 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Robert Love <rml@novell.com>
To: dtor_core@ameritech.net
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d500050826122768cd3612@mail.gmail.com>
References: <1125069494.18155.27.camel@betsy>
	 <d120d500050826122768cd3612@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 15:39:01 -0400
Message-Id: <1125085141.18155.97.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 14:27 -0500, Dmitry Torokhov wrote:

> What this completion is used for? I don't see any other references to it.

It was the start of the release() routine, but I decided to move to
platform_device_register_simple() and use its release, instead.  So this
is gone now in my tree.

> I'd rather you used absolute coordinates and set up
> hdaps_idev->absfuzz to do the filtering.

Me too.

> This is racy - 2 threads can try to do this simultaneously.

Fixed.  Thanks.

> > +
> > +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_position);
> > +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_variance);
> > +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_temp);
> > +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_calibrate);
> > +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_mousedev);
> > +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_mousedev_threshold);
> > +       device_create_file(&hdaps_plat_dev.dev, &dev_attr_mousedev_poll_ms);
> > +
> 
> What about using sysfs_attribute_group?

I don't see this in my tree?

	Robert Love


