Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVBXVPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVBXVPh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVBXVPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:15:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:3769 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262472AbVBXVP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:15:26 -0500
Date: Thu, 24 Feb 2005 13:15:12 -0800
From: Greg KH <greg@kroah.com>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
Message-ID: <20050224211512.GC24969@kroah.com>
References: <20050224175918.GA7627@mail.muni.cz> <20050224181347.GA10847@kroah.com> <20050224182300.GA7778@mail.muni.cz> <20050224184928.GA11490@kroah.com> <20050224190548.GA7978@mail.muni.cz> <20050224191243.GD11806@kroah.com> <20050224191809.GB7978@mail.muni.cz> <20050224192207.GB12018@kroah.com> <421E34B1.9050803@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E34B1.9050803@tiscali.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 09:10:25PM +0100, Matthias-Christian Ott wrote:
> But why does the usb mass storage give this information to the usb 
> driver? Shouldn't it report that it works with 480Mbit too?

What do you mean?  The usb-storage driver doesn't care at all what the
speed is.  Only the USB core and host controller drivers do.

And if you look at the raw descriptors, which is what is displayed in
/proc/bus/usb/devices in human readable form, the device itself tells
the computer what speed it supports.  The host never tells the device
what speed to run at.

Hope this helps,

greg k-h
