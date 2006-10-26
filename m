Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423462AbWJZMgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423462AbWJZMgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423466AbWJZMgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:36:37 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:57784 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1423462AbWJZMgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:36:36 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: usb initialization order (usbhid vs. appletouch)
Date: Thu, 26 Oct 2006 14:36:47 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1161856438.5214.2.camel@no.intranet.wo.rk> <200610261220.05707.oliver@neukum.org> <1161863380.18657.38.camel@no.intranet.wo.rk>
In-Reply-To: <1161863380.18657.38.camel@no.intranet.wo.rk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610261436.47463.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 26. Oktober 2006 13:49 schrieb Soeren Sonnenburg:
> On Thu, 2006-10-26 at 12:20 +0200, Oliver Neukum wrote:
> > Am Donnerstag, 26. Oktober 2006 11:53 schrieb Soeren Sonnenburg:
> > > Dear all,
> > > 
> > > I've noticed that the appletouch driver needs to be loaded *before* the
> > > usbhid driver to function. This is currently impossible when built into
> > > the kernel (and not modules). So I wonder how one can change the
> > > ordering of when the usb drivers are loaded.
> > > 
> > > Suggestions ?
> > 
> > Add a quirk to HID. Messing around with probing orders is not
> > a sure thing.
> 
> what do you have in mind ? if appletouch is turned on ignore IDs that
> appear in appletouch ?

Yes, or even make it unconditional. There is a specific driver for a device.
It exists for a reason.

	Regards
		Oliver
