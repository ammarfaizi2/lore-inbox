Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWJHOQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWJHOQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWJHOQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:16:49 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:1454 "EHLO
	asav07.insightbb.com") by vger.kernel.org with ESMTP
	id S1751136AbWJHOQs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:16:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAJCkKEWBToo2LA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Sun, 8 Oct 2006 10:16:45 -0400
User-Agent: KMail/1.9.3
Cc: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610080020.49158.david-b@pacbell.net> <200610081039.59777.oliver@neukum.org>
In-Reply-To: <200610081039.59777.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610081016.46677.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 October 2006 04:39, Oliver Neukum wrote:
> Am Sonntag, 8. Oktober 2006 09:20 schrieb David Brownell:
> > > If a device is always opened, as mice are, it will not be suspended.
> > > Yet they can be without any data to deliver forever.
> > 
> > In 2.6.19-rc1 read Documentation/power/devices.txt about runtime
> > suspend states.  Then think about how why mouse in a runtime suspend
> > state, with remote wakeup enabled, looks externally ** EXACTLY ** like
> > a mouse that's fully active ....
> 
> I've done so. And I've read the HID spec. It just says that a mouse
> may support remote wakeup, not what should wake it up. A device
> that wakes only if a button is clicked is within spec.
> 

And that's what some devices do. Apologies for a non-USB example, but
since we are talking about input devices and it would be nice to have
the rules consistent across all hardware interfaces I think it's OK...
Synaptics PS/2 touchpad can be put into a sleep mode where it only
reacts on button presses. While this behavior is reasonable for system-
wide suspend it would hardly work for autosuspend.

-- 
Dmitry
