Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbSAGTbT>; Mon, 7 Jan 2002 14:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285703AbSAGTbJ>; Mon, 7 Jan 2002 14:31:09 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:16651 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285691AbSAGTbD>;
	Mon, 7 Jan 2002 14:31:03 -0500
Date: Mon, 7 Jan 2002 11:29:03 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Dave Jones <davej@suse.de>, Paul Jakma <paulj@alphyra.ie>,
        knobi@knobisoft.de, linux-kernel@vger.kernel.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020107192903.GB8413@kroah.com>
In-Reply-To: <20020107185001.GK7378@kroah.com> <Pine.LNX.4.33.0201071109490.28000-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201071109490.28000-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 10 Dec 2001 16:58:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 11:19:06AM -0800, Patrick Mochel wrote:
> 
> It's very closely related; kinda like kissing cousins.
> 
> /sbin/hotplug is called from the kernel only, right?

Right.  But there's no reason it can't be called from any other place.
It's just a userspace program with a well documented interface :)

> I see no reason to change that at all for notification of devices that are
> plugged in/removed by suprise.

Also realize that the first scan of a bus looks just like a device was
plugged in from the subsystem's point of view.

> I was thinking, though, more along the lines of triggering the probe for
> devices that the kernel has a tough time finding on its own. E.g. peer
> Host/PCI bridges, batteries, etc.

Ah, things that do not have individual kernel module drivers right now?

greg k-h
