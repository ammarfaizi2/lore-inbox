Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWJ1STP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWJ1STP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWJ1STP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:19:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30940 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751324AbWJ1STN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:19:13 -0400
Date: Sat, 28 Oct 2006 11:14:54 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, zaitcev@redhat.com
Subject: Re: usb initialization order (usbhid vs. appletouch)
Message-Id: <20061028111454.787894e8.zaitcev@redhat.com>
In-Reply-To: <1162054576.3769.15.camel@localhost>
References: <1161856438.5214.2.camel@no.intranet.wo.rk>
	<200610261220.05707.oliver@neukum.org>
	<1161863380.18657.38.camel@no.intranet.wo.rk>
	<200610261436.47463.oliver@neukum.org>
	<1162054576.3769.15.camel@localhost>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006 18:56:16 +0200, Soeren Sonnenburg <kernel@nn7.de> wrote:

> > > > > I've noticed that the appletouch driver needs to be loaded *before* the
> > > > > usbhid driver to function. This is currently impossible when built into
> > > > > the kernel (and not modules). So I wonder how one can change the
> > > > > ordering of when the usb drivers are loaded.
> > > > > 
> > > > > Suggestions ?
> > > > 
> > > > Add a quirk to HID. Messing around with probing orders is not
> > > > a sure thing.
> > > 
> > > what do you have in mind ? if appletouch is turned on ignore IDs that
> > > appear in appletouch ?
> > 
> > Yes, or even make it unconditional. There is a specific driver for a device.
> > It exists for a reason.
> 
> OK, so I tried adding all of them to the HID_QUIRK_IGNORE LIST, i.e.

This, of course, cannot possibly work, as we discussed a month ago.
 http://lkml.org/lkml/2006/10/1/18

So, you two are just beating a dead horse. It's time to write the code
which identifies Apple devices and not try to ride a quirk.

-- Pete
