Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTFKFhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 01:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbTFKFhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 01:37:19 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:49403 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264152AbTFKFhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 01:37:18 -0400
Subject: Re: Oops during boot when init USB mouse, 2.5.70-bk14
From: Martin Schlemmer <azarah@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <1055229578.5281.236.camel@workshop.saharacpt.lan>
References: <1055224690.5281.224.camel@workshop.saharacpt.lan>
	 <20030610065414.GA4373@kroah.com>
	 <1055229578.5281.236.camel@workshop.saharacpt.lan>
Content-Type: text/plain
Organization: 
Message-Id: <1055309732.5279.1544.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 11 Jun 2003 07:35:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 09:19, Martin Schlemmer wrote:
> > On Tue, 2003-06-10 at 08:54, Greg KH wrote:
> > > On Tue, Jun 10, 2003 at 07:58:10AM +0200, Martin Schlemmer wrote:
> > > > Hi
> > > > 
> > > > I am getting the following during mouse/keyboard is initialized,
> > > > but it seems to be more specific to the mouse.  Both are USB.
> > > > It was fine with last 2.5.69 kernel, but started when i switched
> > > > to 2.5.70-bk12 (have not tried vanilla, or earlier 2.5.70 bk's,
> > > > as swamped at work).  NB: there are no oops 'header'.
> > > > 
> > > > -------------
> > > > Trace; c01a9466 <kobject_get+4c/4e>
> > > > Trace; c0201830 <get_device+18/21>
> > > > Trace; c0203001 <class_device_add+132/137>
> > > > Trace; c0202ec2 <class_device_initialize+16/23>
> > > 
> > > You are hitting the WARN_ON() call in kobject_get(), this isn't a oops.
> > > 
> > > But what is wierd is the calls to class_* for a USB mouse, as I don't
> > > think there are any mouse class code in the current kernel.  Does your
> > > mouse show up under /sys/class anywhere?
> > > 
> >

Ok was slightly wrong.  It is during init of the USB keyboard, and yes,
it is under /sys/class/.  I will try to have a look, but currently
trying to find out how to get my sensors working.


Regards,

-- 
Martin Schlemmer


