Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSLTT33>; Fri, 20 Dec 2002 14:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSLTT33>; Fri, 20 Dec 2002 14:29:29 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8711 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265305AbSLTT2x>;
	Fri, 20 Dec 2002 14:28:53 -0500
Date: Fri, 20 Dec 2002 11:33:54 -0800
From: Greg KH <greg@kroah.com>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Please use the 'usbfs' filetype instead
Message-ID: <20021220193354.GE12128@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20021220190538.GC12128@kroah.com> <Pine.LNX.4.43.0212201417500.2382-100000@morpheus> <20021220193050.GD12128@kroah.com> <20021220190538.GC12128@kroah.com> <Pine.LNX.4.43.0212201417500.2382-100000@morpheus> <Pine.LNX.4.43.0212201327410.2382-100000@morpheus> <20021220190538.GC12128@kroah.com> <Pine.LNX.4.43.0212201327410.2382-100000@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220193050.GD12128@kroah.com> <Pine.LNX.4.43.0212201417500.2382-100000@morpheus> <20021220190538.GC12128@kroah.com> <Pine.LNX.4.43.0212201327410.2382-100000@morpheus>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copied to lkml for others to refer to once 2.5.53 comes out...

On Fri, Dec 20, 2002 at 01:29:41PM -0500, Burton Windle wrote:
> Hello. I'm getting this message once per bootup, but I can't figure out
> why.
> 
> uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4
> uhci-hcd 00:07.2: irq 11, io base 0000cce0
> Please use the 'usbfs' filetype instead, the 'usbdevfs' name is depreciated.
> drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
> hub 1-0:0: USB hub found
> hub 1-0:0: 2 ports detected
> 
> I see this change just started in 2.5.52-bk4. My /etc/fstab doesn't have
> usbdevfs, it has usbfs.
> 
> I've grepped my entire /etc, and don't find any references to 'usbdevfs'.
> Is this a warning about the kernel using it, or user-space using that
> name? Can you offer a clue where I might find this, and correct it?

Is this a Red Hat machine?
If so, look in /etc/rc.sysinit.  That's where Red Hat mounts usbdevfs.

For a Debian box, it's done in /etc/hotplug/usb.rc.  I don't know where
the other distros do this, but it's probably one of the above two
places.

Don't worry, the usbdevfs name will stick around and work through 2.6,
I'm just trying to warn people that it will go away in 2.7.

Also, more recent 2.4 kernels support the usbfs name, if you want to
change the rc.sysinit file and not worry about it anymore.

Hope this helps,

greg k-h
