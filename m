Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274804AbTHKU6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274813AbTHKU6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:58:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:44480 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274804AbTHKU6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:58:14 -0400
Date: Mon, 11 Aug 2003 13:50:48 -0700
From: Greg KH <greg@kroah.com>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: lost mouse  synchronization after apm-suspend
Message-ID: <20030811205048.GA18476@kroah.com>
References: <3bba01c35e5f$ba01f3a0$97ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bba01c35e5f$ba01f3a0$97ee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 07:13:17PM +0900, Norman Diamond wrote:
> "Greg KH" <greg@kroah.com> wrote to someone else:
> 
> > Unload all usb drivers before suspending please.
> 
> I hope this isn't a general rule?  I can't keep up with the list, but I saw
> this message, and it looks like a disaster.

Right now, yes that is the response if anyone has any problems with
this, sorry.

> There are a lot of small-size desktop machines that depend on USB keyboards
> because they don't have PS/2 ports.  In some cases the keyboard includes a
> PS/2 hub for a PS/2 mouse, but in some cases the keyboard doesn't even have
> that so the mouse is also USB.  In all of these cases the connection to the
> CPU goes through a USB port.
> 
> How should the user restore their keyboard after resuming from suspend?  A
> modprobe or insmod command?  In the vast majority of these cases the input
> of a command would depend on having the USB keyboard already working.

Have the resume script re-load the drivers.  A lot of people are already
doing this.

thanks,

greg k-h
