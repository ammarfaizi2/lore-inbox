Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWBNLxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWBNLxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWBNLxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:53:13 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:50256 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1161021AbWBNLxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:53:12 -0500
Message-ID: <43F1C4A8.1050202@tls.msk.ru>
Date: Tue, 14 Feb 2006 14:53:12 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring
 up a hornets' nest))
References: <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <20060212120450.GA93069@dspnet.fr.eu.org> <20060212164633.GA2941@kroah.com> <20060212211406.GA48606@dspnet.fr.eu.org> <20060213062412.GB2335@kroah.com> <20060213164911.GB75835@dspnet.fr.eu.org> <20060213175046.GA20952@kroah.com> <20060213195322.GB89006@dspnet.fr.eu.org>
In-Reply-To: <20060213195322.GB89006@dspnet.fr.eu.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
[]
> 4- sysfs has all the information you need, just read it
[]
> Answer 4 would be very nice if it was correct.  sysfs is pretty much
> mandatory at that point, and modulo some fixable incompleteness
> provides all the capability information and model names and everything
> needed to find the useful devices.  What it does not provide is the
> mapping between a device as found in sysfs, and a device node you can
> open to talk to the device.  You get the major/minor, which allows you
> to create a temporary device node iff you're root.  Or you can scan
> all the nodes in /dev to find the one to open, which is kinda
> ridiculous and inefficient.  Or you have to go back to udev/hal to ask
> for the sysfs node/device node path mapping, and then why use sysfs in
> the first place.

That's exactly the point why I always wanted to have automatic minimal-devfs-
alike in kernel, similar to ndevfs but complete: so that kernel names of
defices are *always* present in /dev, regardless of the presense of udev or
something else.  All the rest - udev, device permissions, "alternative"
names (like /dev/cdrom etc) can be built on top of that "kernel naming scheme",
but the key point is that we *always* have a device in /dev/ named exactly
the same as kernel "thinks" of it - so eg, /proc/partitions, dmesg output,
sysfs scanning etc etc will produce real and useful results.

But oh.. Am I starting new [n]devfs flamewar?

/mjt
