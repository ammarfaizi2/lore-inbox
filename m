Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263444AbUDZUV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUDZUV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUDZUV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:21:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:25226 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263444AbUDZUV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:21:26 -0400
Date: Mon, 26 Apr 2004 13:19:43 -0700
From: Greg KH <greg@kroah.com>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
Message-ID: <20040426201943.GA29962@kroah.com>
References: <s5g8ygi4l3q.fsf@patl=users.sf.net> <408D65A7.7060207@nortelnetworks.com> <s5gisfm34kq.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gisfm34kq.fsf@patl=users.sf.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 03:50:52PM -0400, Patrick J. LoPresti wrote:
> 
> I see how I can scan for a USB keyboard after loading the USB host
> controller module.  I think.  But what do I look for, exactly, to tell
> when hid.o has hooked itself up to the keyboard?

I can think of at least 2 different ways (there are probably more):
	- look at the device in /proc/bus/usb/devices and wait until the
	  driver is bound to that device "(hid)" will show up as the
	  driver bound to that interface
	- look at the sysfs directory for the hid driver and wait for
	  the symlink to the device shows up.  This should be at
	  /sys/bus/usb/drivers/hid

Hope this helps,

greg k-h
