Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUJORYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUJORYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUJORXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:23:37 -0400
Received: from ida.rowland.org ([192.131.102.52]:18948 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S268214AbUJORVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:21:48 -0400
Date: Fri, 15 Oct 2004 13:21:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: Laurent Riffard <laurent.riffard@free.fr>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
 : oops...]
In-Reply-To: <1097858939.2820.3.camel@deimos.microgate.com>
Message-ID: <Pine.LNX.4.44L0.0410151318580.1052-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Paul Fulghum wrote:

> There was a question in my mind about the hcd->description field.
> Should it be unique for each device instance instead
> of uniform for all device instances on a driver?

As I understand it, the description field is just a human-readable string
that indicates what sort of device the hcd is.  It doesn't need to be
unique.  In fact, the kerneldoc for request_irq() (without the updates)
says that the dev_id value must be unique but says nothing about the
devname.

Alan Stern

