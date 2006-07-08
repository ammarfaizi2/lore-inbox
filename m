Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWGHRU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWGHRU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWGHRU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:20:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16398 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964907AbWGHRU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:20:57 -0400
Date: Sat, 8 Jul 2006 18:20:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike Galbraith <efault@gmx.de>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Opinions on removing /proc/tty?
Message-ID: <20060708172047.GA23882@flint.arm.linux.org.uk>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike Galbraith <efault@gmx.de>,
	Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com> <1152344452.7922.11.camel@Homer.TheSimpsons.net> <9e4733910607080712y248f61b9q7444b754516c4d6a@mail.gmail.com> <1152370102.27368.5.camel@localhost.localdomain> <9e4733910607080920t51957e28sa131f86876219891@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910607080920t51957e28sa131f86876219891@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 12:20:06PM -0400, Jon Smirl wrote:
> I'll put together a patch making it mountable. Is there any specific
> info that needs to be added to sysfs?

Adding info to the sysfs side of tty devices is rather fraught (or was
last time I looked - I'd like to do exactly that with serial_core.)

Unfortunately, until it becomes easier (and maybe it recently has now
that tty_register_device returns the class device struct), /proc/tty
needs to stay.  But... I heard that Greg wants to remove struct
class_device...

So until this area gets sorted out I'm in no hurry to make any
changes in this area.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
