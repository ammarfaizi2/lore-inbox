Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUJRQ5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUJRQ5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUJRQ5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:57:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:20697 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266888AbUJRQ5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:57:34 -0400
Date: Mon, 18 Oct 2004 09:45:39 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Alexandre Oliva <aoliva@redhat.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: forcing PS/2 USB emulation off
Message-ID: <20041018164539.GC18169@kroah.com>
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br> <200410172248.16571.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410172248.16571.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 10:48:16PM -0500, Dmitry Torokhov wrote:
> 
> BTW, I think that handoff should be activated by default. I am lurking
> in Gentoo forums and there are coultless people having problems with
> their mice/touchpads detected properly unless they load their USB drivers
> first.

I'm a little leary of changing the way the kernel grabs the USB hardware
from the way we have been doing it for the past 6 years.  So by
providing the option for people who have broken machines like these, we
will let them work properly, and it should not affect any of the zillion
other people out there with working hardware.

Or, if we can determine a specific model of hardware that really needs
this option enabled, we can do that automatically.  If you look at the
patch, we do that for some specific IBM machines for this very reason.

Is there any consistancy with the type of hardware that you see being
reported for this issue?

thanks,

greg k-h
