Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbWJEQWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbWJEQWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWJEQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:22:55 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:26641 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751582AbWJEQWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:22:54 -0400
Date: Thu, 5 Oct 2006 12:22:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: usbatm@lists.infradead.org, <linux-usb-devel@lists.sourceforge.net>,
       <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       <linux-kernel@vger.kernel.org>, ueagle <ueagleatm-dev@gna.org>,
       matthieu castet <castet.matthieu@free.fr>
Subject: Re: [linux-usb-devel] [PATCH 1/3] UEAGLE : be suspend friendly
In-Reply-To: <200610050917.36442.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0610051221520.6596-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Duncan Sands wrote:

> > Plug/unplug should be easy enough to simulate from usb driver, no?
> 
> if a USB driver doesn't define suspend/resume methods, then the core simply
> unplugs it on suspend, and replugs on resume (IIRC).

No longer true, and IIRC it never was.  All that happens is that URB 
submissions fail with -EHOSTUNREACH once the device is suspended.

Alan Stern

