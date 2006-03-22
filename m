Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWCVQ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWCVQ7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWCVQ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:59:18 -0500
Received: from xenotime.net ([66.160.160.81]:63874 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751382AbWCVQ7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:59:17 -0500
Date: Wed, 22 Mar 2006 09:01:25 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: abergman@de.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] hpet header sanitization
Message-Id: <20060322090125.8fc13711.rdunlap@xenotime.net>
In-Reply-To: <20060322111446.GA7675@turing.informatik.uni-halle.de>
References: <20060321144607.153d1943.rdunlap@xenotime.net>
	<200603221118.43853.abergman@de.ibm.com>
	<20060322111446.GA7675@turing.informatik.uni-halle.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006 12:14:46 +0100 Clemens Ladisch wrote:

> Arnd Bergmann wrote:
> > On Tuesday 21 March 2006 23:46, Randy.Dunlap wrote:
> > > +#define        HPET_IE_ON      _IO('h', 0x01)  /* interrupt on */
> > > +#define        HPET_IE_OFF     _IO('h', 0x02)  /* interrupt off */
> > > +#define        HPET_INFO       _IOR('h', 0x03, struct hpet_info)
> > > +#define        HPET_EPI        _IO('h', 0x04)  /* enable periodic */
> > > +#define        HPET_DPI        _IO('h', 0x05)  /* disable periodic */
> > > +#define        HPET_IRQFREQ    _IOW('h', 0x6, unsigned long)   /* IRQFREQ usec */
> > 
> > By the way, HPET_INFO and HPET_IRQFREQ don't work for 32 bit user space,
> > the driver needs a compat_ioctl() method to handle those.
> 
> There isn't any program (except the example in the docs) that uses any
> of these ioctls, and I'm writing patches to make this device available
> through portable timer APIs like hrtimer/POSIX clocks/ALSA that are much
> easier to use besides, so I think it would be a good idea to just
> schedule these ioctls for removal.

How do you (or can you) know that there are no programs that use
that ioctl?  Yes, scheduling for removal would be OK.

---
~Randy
