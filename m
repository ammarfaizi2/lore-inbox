Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278617AbRJSTU5>; Fri, 19 Oct 2001 15:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278616AbRJSTUr>; Fri, 19 Oct 2001 15:20:47 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15611
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278615AbRJSTUe>; Fri, 19 Oct 2001 15:20:34 -0400
Date: Fri, 19 Oct 2001 12:21:01 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Tim Jansen <tim@tjansen.de>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011019122101.G2467@mikef-linux.matchmail.com>
Mail-Followup-To: Tim Jansen <tim@tjansen.de>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net> <15uerh-0NbBEeC@fmrl04.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15uerh-0NbBEeC@fmrl04.sul.t-online.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 09:02:09PM +0200, Tim Jansen wrote:
> On Friday 19 October 2001 20:26, Patrick Mochel wrote:
> > There are equivalents in USB. But, neither of them are globally unique
> > identifiers for the device. That doesn't necessarily mean that one
> > couldn't be ascertained from the device; ethernet cards do have MAC
> > addresses. But, I don't think that many will have a ID/serial number.
> > [...]
> > Which leads me to the question: what real benefit does this have? Why
> > would you ever want to do a global search in kernel space for a particular
> > device? 
> 
> For example for harddisks. You usually want them to be mounted in the same 
> directory. 

When is /etc/fstab going to support this?

#Or if you have several printers of the same type connected your
> computer you need a way of identifying them. 

/dev/ttyS0 and /dev/lp0

>Or for ethernet adapters: 
> because each is connected to a different network, so you need to assign 
> different IP addresses to them.
>

I haven't seen anything assign ethX assign a certain order, except for
ordered module loading, and then if there are multiple devices with the same
driver, the order is chosen by bus scanning order, or module option.

> Actually most USB harddisks, printers and network adapters have unique serial 
> number (you have to be careful though as some claim to have a serial number, 
> but it is not unique).
>

How different do you expect this new driver model to be?

Does anyone know if devfs will, or has any plans to support any of the above
features?
