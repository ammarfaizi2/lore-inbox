Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754732AbWKMOJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbWKMOJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbWKMOJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:09:12 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:34258 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1754732AbWKMOJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:09:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Mon, 13 Nov 2006 15:06:26 +0100
User-Agent: KMail/1.9.1
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Andrew Morton" <akpm@osdl.org>, "Solomon Peachy" <pizza@shaftnet.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       "LKML" <linux-kernel@vger.kernel.org>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5441@labex2.corp.trema.com>
In-Reply-To: <D0233BCDB5857443B48E64A79E24B8CE6B5441@labex2.corp.trema.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611131506.27698.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 13 November 2006 11:51, Christian Hoffmann wrote:
> 
> > -----Original Message-----
> > From: Pavel Machek [mailto:pavel@ucw.cz] 
> > Sent: Sunday, November 12, 2006 1:14 PM
> > To: Benjamin Herrenschmidt
> > Cc: Christian Hoffmann; Andrew Morton; Solomon Peachy; Rafael 
> > J. Wysocki; linux-fbdev-devel@lists.sourceforge.net; LKML; 
> > Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl
> > Subject: Re: Fwd: [Suspend-devel] resume not working on acer 
> > ferrari 4005 with radeonfb enabled
> > 
> > Hi!
> > 
> > > > Then the radeonfb doesn't kick in at all (guess some pci ids are 
> > > > added in that patch).
> > > > 
> > > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > > 
> > > In that case (vesafb), when does the screen come back 
> > precisely ? Do 
> > > you get console mode back and then X ? Or it only comes back when 
> > > going back to X ? Do you have some userland-type vbetool 
> > thingy that 
> > > bring it back ?
> > 
> > He's using s3_bios+s3_mode, so kernel does some BIOS calls to 
> > reinit the video. It should come out in text mode, too.
> > 
> > Christian, can you unload radeonfb before suspend/reload it 
> > after resume?
> 
> Will it work if radeonfb is compiled as module? I think I had problems
> with that, but I'll try again.
> 
> > 
> > Next possibility is setting up serial console and adding some 
> > printks to radeon...
> 
> Unfortunatly, the laptop doesn't have serial port. I tried to get a USB
> device (pocketpc) read the USB serial, but I only partially succeeded. I
> can pass console=ttyUSB0 to the kernel and load the ipaq serial console
> driver as it oopses. I am able to echo strings to /dev/ttyUSB0  and read
> them on the ipaq, but I am not able to "deviate" the kernel messages to
> that port. Any hints on how to do that would be very appreciated, I
> didn't find anything usefull on the web. (I tried with setconsole
> /dev/ttyUSB0 but it gives error msg about device busy or something) 

Would it be practicable to use netconsole on your box?  If so, it should work.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
