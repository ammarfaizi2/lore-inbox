Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVGJVP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVGJVP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVGJVNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 17:13:55 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:17827 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262084AbVGJVME convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 17:12:04 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.12 - USB Mouse not detected
Date: Sun, 10 Jul 2005 17:11:59 -0400
User-Agent: KMail/1.8.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507101638470.24579-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507101638470.24579-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200507101712.00181.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 July 2005 16:42, Alan Stern wrote:
> > Beginning 2.6.12 my Wireless USB Mouse is not detected in the first
> > attempt - Meaning if I boot the machine with the mouse connected, it's
> > not detected until I disconnect the mouse and then reconnect it.
>
> That's not quite right.  Your log clearly shows the mouse was detected and
> assigned address 2.
Yeah, I shoud have worded it properly - kernel detects the device but it's 
unusable since the driver for it - USBHID wasn't loaded.
>
> >  It works fine after the disconnect-reconnect cycle. Looking at the
> > dmesg, it seems that at first time it forgets to register the hiddev
> > driver - mysteriously, it remembers the second time.
>
> Exactly.  The hiddev driver wasn't loaded the first time, which makes this
> sound like some sort of hotplug failure.  Are your hotplug and udev
> packages up to date?
I hadn't changed anything (except for the system board which failed recently) 
and it used to work fine - So I didnt suspect hotplug to be the culprit - 
another reason for not considering hotplug was it worked the second time with 
identical setup.

What's funny - I rebuilt hotplug - same version - and it works now! Probably 
it was failing for some reason the first time.

Thanks!

Parag
