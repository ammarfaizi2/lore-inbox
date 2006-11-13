Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755146AbWKMPmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbWKMPmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbWKMPmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:42:13 -0500
Received: from wshld2.trema.com ([194.103.215.196]:23201 "HELO
	webshieldout.corp.trema.com") by vger.kernel.org with SMTP
	id S1755146AbWKMPmL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:42:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
Subject: RE: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 13 Nov 2006 11:51:51 +0100
Message-ID: <D0233BCDB5857443B48E64A79E24B8CE6B5441@labex2.corp.trema.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Thread-Index: AccGU3FdOXtHLHwoR5q+t6uMAciRpAAvZiCw
From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
To: "Pavel Machek" <pavel@ucw.cz>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Solomon Peachy" <pizza@shaftnet.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       <linux-fbdev-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>, <Christian@ogre.sisk.pl>,
       <Hoffmann@albercik.sisk.pl>
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz] 
> Sent: Sunday, November 12, 2006 1:14 PM
> To: Benjamin Herrenschmidt
> Cc: Christian Hoffmann; Andrew Morton; Solomon Peachy; Rafael 
> J. Wysocki; linux-fbdev-devel@lists.sourceforge.net; LKML; 
> Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl
> Subject: Re: Fwd: [Suspend-devel] resume not working on acer 
> ferrari 4005 with radeonfb enabled
> 
> Hi!
> 
> > > Then the radeonfb doesn't kick in at all (guess some pci ids are 
> > > added in that patch).
> > > 
> > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > 
> > In that case (vesafb), when does the screen come back 
> precisely ? Do 
> > you get console mode back and then X ? Or it only comes back when 
> > going back to X ? Do you have some userland-type vbetool 
> thingy that 
> > bring it back ?
> 
> He's using s3_bios+s3_mode, so kernel does some BIOS calls to 
> reinit the video. It should come out in text mode, too.
> 
> Christian, can you unload radeonfb before suspend/reload it 
> after resume?

Will it work if radeonfb is compiled as module? I think I had problems
with that, but I'll try again.

> 
> Next possibility is setting up serial console and adding some 
> printks to radeon...

Unfortunatly, the laptop doesn't have serial port. I tried to get a USB
device (pocketpc) read the USB serial, but I only partially succeeded. I
can pass console=ttyUSB0 to the kernel and load the ipaq serial console
driver as it oopses. I am able to echo strings to /dev/ttyUSB0  and read
them on the ipaq, but I am not able to "deviate" the kernel messages to
that port. Any hints on how to do that would be very appreciated, I
didn't find anything usefull on the web. (I tried with setconsole
/dev/ttyUSB0 but it gives error msg about device busy or something) 

Chris


Privileged or confidential information may be contained in this message.  If you are not the addressee of this message please notify the sender by return and thereafter delete the message, and you may not use, copy, disclose or rely on the information contained in it. Internet e-mail may be susceptible to data corruption, interception and unauthorised amendment for which Wall Street Systems does not accept liability. Whilst we have taken reasonable precautions to ensure that this e-mail and any attachments have been swept for viruses, Wall Street Systems does not accept liability for any damage sustained as a result of viruses.  Statements in this message or attachments that do not relate to the business of  Wall Street Systems are neither given nor endorsed by the company or its Directors.

