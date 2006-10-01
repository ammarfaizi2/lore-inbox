Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751725AbWJAJUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbWJAJUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 05:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWJAJUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 05:20:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751724AbWJAJUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 05:20:38 -0400
Date: Sun, 1 Oct 2006 02:20:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: David Brownell <david-b@pacbell.net>,
       Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.18-git] RTC class uses subsys_init
Message-Id: <20061001022022.d7f86b39.akpm@osdl.org>
In-Reply-To: <20061001090717.GA14885@aepfle.de>
References: <200609282333.34224.david-b@pacbell.net>
	<20061001090717.GA14885@aepfle.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 11:07:17 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> On Thu, Sep 28, David Brownell wrote:
> 
> 
> > +++ linux/drivers/rtc/rtc-sysfs.c	2006-07-30 16:15:50.000000000 -0700
> > @@ -116,7 +116,7 @@
> >  	class_interface_unregister(&rtc_sysfs_interface);
> >  }
> >  
> > -module_init(rtc_sysfs_init);
> > +subsys_init(rtc_sysfs_init);
> >  module_exit(rtc_sysfs_exit);
> 
> subsys_init is not defined, but the change is in Linus tree now.

doh.  But it still compiled.

drivers/rtc/rtc-sysfs.c:119: warning: data definition has no type or storage class
drivers/rtc/rtc-sysfs.c:119: warning: type defaults to 'int' in declaration of 'subsys_init'
drivers/rtc/rtc-sysfs.c:119: warning: parameter names (without types) in function declaration
drivers/rtc/rtc-sysfs.c:110: warning: 'rtc_sysfs_init' defined but not used

I'll fix it up.

(Wonders how it passed runtime testing..)
