Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTFBUus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTFBUus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:50:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:37037 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263802AbTFBUuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:50:44 -0400
Date: Mon, 2 Jun 2003 14:05:37 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: pcmcia oops (a real one! honest!)
Message-ID: <20030602210537.GA6666@kroah.com>
References: <20030528042610.GD6501@zip.com.au> <20030529090209.B12513@flint.arm.linux.org.uk> <20030529212139.GA25971@kroah.com> <20030531154142.GA473@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531154142.GA473@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 01:41:42AM +1000, CaT wrote:
> On Thu, May 29, 2003 at 02:21:39PM -0700, Greg KH wrote:
> > On Thu, May 29, 2003 at 09:02:09AM +0100, Russell King wrote:
> > > On Wed, May 28, 2003 at 02:26:10PM +1000, CaT wrote:
> > > > removed my xircom pcmcia realport card and put in another. End result was
> > > > total loss of ps2 keyboard functionality (everything else, inc the ps2 mouse
> > > > still works). I then removed the xircom card. The following was in dmesg:
> > > 
> > > I'm assuming that this is something Gregkh needs to look into and not
> > > myself; my guess is that it's related to the pci device accounting stuff.
> > > 
> > > Greg?
> > 
> > Yeah, it could be.  Cat, can you revert the following patch from your
> > tree and let me know if it fixes your problem or not?
> 
> The kernel no longer crashes on remove and I can reinsert and it
> recognises the card without hassle. I do get no messages on eject though
> (about devices being deregistered, etc) but I get msgs on insert (about
> them getting regstered etc). One time I didn't get the card recognised
> at all on insert... dunno if that was myfault or not but on eject and
> reinsert all was fine.

Ok, I've duplicated this here with a PCI card containing a bridge on a
pci hotplug system, so I'll work on tracking this down...

thanks for letting me know.

greg k-h
