Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262929AbSJBB4D>; Tue, 1 Oct 2002 21:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262931AbSJBB4D>; Tue, 1 Oct 2002 21:56:03 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:42504 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262929AbSJBB4D>;
	Tue, 1 Oct 2002 21:56:03 -0400
Date: Tue, 1 Oct 2002 18:59:03 -0700
From: Greg KH <greg@kroah.com>
To: Nick Sanders <sandersn@btinternet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic 2.5.39 when starting hotplug
Message-ID: <20021002015903.GA11453@kroah.com>
References: <200209281324.47486.sandersn@btinternet.com> <20020928185554.GA17684@kroah.com> <200210020222.40880.sandersn@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210020222.40880.sandersn@btinternet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 02:22:40AM +0100, Nick Sanders wrote:
> Sorry about the last report not the most informative, I'm still getting a 
> kernel panic with 2.5.40. I think it's my Alcatel USB Speedtouch Modem as it 
> only panics when I plug it in.

Are you using the new "in-kernel" driver for this device?  Or the
userspace driver?  Hm, in looking at your .config, you're not using the
kernel driver, any reason you aren't?

And if you move usbmodules to something else (like usbmodules.orig), it
will not be run by the hotplug code.  Does that prevent the oops?

thanks,

greg k-h
