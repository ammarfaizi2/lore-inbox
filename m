Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261993AbSIYO5a>; Wed, 25 Sep 2002 10:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261995AbSIYO53>; Wed, 25 Sep 2002 10:57:29 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:23048 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261993AbSIYO53>;
	Wed, 25 Sep 2002 10:57:29 -0400
Date: Wed, 25 Sep 2002 08:01:29 -0700
From: Greg KH <greg@kroah.com>
To: Tim Waugh <twaugh@redhat.com>
Cc: Steve Underwood <steveu@coppice.org>, linux-kernel@vger.kernel.org
Subject: Re: USB IEEE1284 gadgets and ppdev
Message-ID: <20020925150129.GC30339@kroah.com>
References: <3D90831A.7060709@coppice.org> <20020924162130.GE9457@redhat.com> <3D91BF58.8080803@coppice.org> <20020925142757.GL9457@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925142757.GL9457@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 03:27:57PM +0100, Tim Waugh wrote:
> On Wed, Sep 25, 2002 at 09:51:20PM +0800, Steve Underwood wrote:
> 
> > As far as I can tell there are only two USB drivers for USB-to-IEEE1284 
> > devices - USS720 for the USS720 device, and usblp for everything else. 
> > Is usblp supposed to hook into ppdev? Is there some other device driver 
> > I missed?
> 
> Not into ppdev; into parport.  It ought to use
> parport_register_port. (It doesn't, currently.)

I understand that the uss720 driver should register with parport, as it
is a USB to parallel port adapter, but the usblp driver should not, as
it is just a pass-through to a printer.  Do you see any advantage to
having usblp registering with parport?

thanks,

greg k-h
