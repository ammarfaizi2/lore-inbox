Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSFERyh>; Wed, 5 Jun 2002 13:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSFERyg>; Wed, 5 Jun 2002 13:54:36 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:27403 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315607AbSFERyf>;
	Wed, 5 Jun 2002 13:54:35 -0400
Date: Wed, 5 Jun 2002 10:51:52 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arndb@de.ibm.com>
Subject: Re: device model documentation 3/3
Message-ID: <20020605175152.GE3275@kroah.com>
In-Reply-To: <200206051224.g55COIZ208776@d06relay02.portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 08 May 2002 15:51:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 04:24:18PM +0200, Arnd Bergmann wrote:
> On Tue Jun 04 2002 - 11:25:19 EST,
> Patrick Mochel <mochel@osdl.org> wrote:
> 
> > When a driver is removed, the list of devices that it supports is 
> > iterated over, and the driver's remove callback is called for each 
> > one. The device is removed from that list and the symlinks removed. 
> 
> Maybe I'm blind, but I can't see how this works without races for
> bridge device drivers. Imagine for example what happens when I rmmod
> a usb hcd driver. Its module use count should be zero as long as the 
> devices attached to it are not in use, right?

A USB HCD driver module use count is always zero, so you can always
unload it.  Now if this is a good idea or not is debatable :)

thanks,

greg k-h
