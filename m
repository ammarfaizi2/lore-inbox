Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272920AbRIMI0q>; Thu, 13 Sep 2001 04:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272921AbRIMI0g>; Thu, 13 Sep 2001 04:26:36 -0400
Received: from gateway.pace.co.uk ([195.44.197.250]:6993 "EHLO
	animal.pace.co.uk") by vger.kernel.org with ESMTP
	id <S272920AbRIMI0V>; Thu, 13 Sep 2001 04:26:21 -0400
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC591@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'Pavel Machek'" <pavel@suse.cz>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: User Space Emulation of Devices
Date: Thu, 13 Sep 2001 09:25:52 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz]
> Sent: 12 September 2001 11:28
> To: Phil Thompson; 'linux-kernel@vger.kernel.org'
> Subject: Re: User Space Emulation of Devices
> 
> 
> Hi!
> 
> > Without going into the gory details, I have a requirement 
> for a device
> > driver that does very little apart from pass on the 
> open/close/read/write
> > "requests" onto a user space application to implement and 
> pass back to the
> > driver.
> > 
> > Does anything like this already exist?
> 
> Something like that which would also pass ioctl()s would be *very*
> welcome.

The best approach I found (for my purposes anyway) was the one used by the
ALSA OSS emulator (and strace as well?) that uses weak & strong symbols in a
pre-loaded shared library to intercept system calls to the device I wanted
to handle in user space.

I'd be surprised if this technique was suitable as a generic approach.

Phil
