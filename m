Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTFJHVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 03:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTFJHVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 03:21:20 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:15355 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262403AbTFJHVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 03:21:19 -0400
Subject: Re: Oops during boot when init USB mouse, 2.5.70-bk14
From: Martin Schlemmer <azarah@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030610065414.GA4373@kroah.com>
References: <1055224690.5281.224.camel@workshop.saharacpt.lan>
	 <20030610065414.GA4373@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055229578.5281.236.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 10 Jun 2003 09:19:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2003-06-10 at 08:54, Greg KH wrote:
> > On Tue, Jun 10, 2003 at 07:58:10AM +0200, Martin Schlemmer wrote:
> > > Hi
> > > 
> > > I am getting the following during mouse/keyboard is initialized,
> > > but it seems to be more specific to the mouse.  Both are USB.
> > > It was fine with last 2.5.69 kernel, but started when i switched
> > > to 2.5.70-bk12 (have not tried vanilla, or earlier 2.5.70 bk's,
> > > as swamped at work).  NB: there are no oops 'header'.
> > > 
> > > -------------
> > > Trace; c01a9466 <kobject_get+4c/4e>
> > > Trace; c0201830 <get_device+18/21>
> > > Trace; c0203001 <class_device_add+132/137>
> > > Trace; c0202ec2 <class_device_initialize+16/23>
> > 
> > You are hitting the WARN_ON() call in kobject_get(), this isn't a oops.
> > 
> > But what is wierd is the calls to class_* for a USB mouse, as I don't
> > think there are any mouse class code in the current kernel.  Does your
> > mouse show up under /sys/class anywhere?
> > 
>
> Will try to track it more closely, thanks.

Forgot to CC the list.

Regards,

-- 
Martin Schlemmer


