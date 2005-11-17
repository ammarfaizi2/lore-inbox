Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVKQRzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVKQRzA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVKQRzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:55:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:19102 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932452AbVKQRzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:55:00 -0500
Date: Thu, 17 Nov 2005 09:18:56 -0800
From: Greg KH <greg@kroah.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EDAC and the sysfs
Message-ID: <20051117171856.GB27534@kroah.com>
References: <20051117070516.GB20760@kroah.com> <20051117172053.87207.qmail@web50112.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117172053.87207.qmail@web50112.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 09:20:53AM -0800, Doug Thompson wrote:
> > But you can just probably use a udev rule to
> > initialize your things
> > properly, that's what all of the distros are now
> > using.
> 
> Ok. That's another area for me to research. edac does
> not have any /dev/ entries, just the files and
> controls previous mentioned. 
> 
> So, from your comment then, udev has some mechanism to
> set controls in sysfs?

udev gets called whenever you add a kobject to the system.  You can then
do whatever you want in udev when this happens.  As an example, on one
distro, when a bluetooth device is created by the kernel, a bluetooth
startup script is run by udev.

thanks,

greg k-h
