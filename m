Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTH1V7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTH1V7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:59:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:19606 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264196AbTH1V7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:59:12 -0400
Date: Thu, 28 Aug 2003 14:59:13 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Novatek USB Keyboard/Mouse Bug
Message-ID: <20030828215913.GA13284@kroah.com>
References: <3F4E796E.5090203@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4E796E.5090203@cornell.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 05:51:42PM -0400, Ivan Gyurdiev wrote:
> Hi, I finally figured out why my wireless mouse turns off and on 
> randomly every once in a while and works depending on the usb hub it is 
> in - it's the keyboard's fault.
> 
> My mouse is:
> PM: Adding info for usb:2-2
> input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-2
> 
> My keyboard is:
> PM: Adding info for usb:2-1
> input: USB HID v1.00 Keyboard [NOVATEK Keyboard NT6881] on 
> usb-0000:00:10.0-1
> PM: Adding info for usb:2-1:0
> input: USB HID v1.00 Mouse [NOVATEK Keyboard NT6881] on 
> usb-0000:00:10.0-1
> PM: Adding info for usb:2-1:1
> 
> 
> As you can see the kernel thinks it's also a mouse, which it definitely 
> is not. I've previously posted this to LKML somewhere, and my 
> impressions were that people don't think it's a bug, since some other 
> model of that keyboard worked together with a mouse somehow. Perhaps 
> that's true, but I do not have a second mouse. The kernel thinks I do, 
> and switching the keyboard and the mouse usb hubs results in mouse 
> devices reordering and X not working with the proper mouse (attempting 
> to use the keyboard as mouse, which apparently does not work).

Why not just use /dev/mice and then you don't have to worry about the
mice ording issue?

Also lots of USB keyboards have a fake "mouse" within them to handle
some of the extended keys.  It's quite common.

thanks,

greg k-h
