Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWEBXgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWEBXgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 19:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWEBXgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 19:36:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:19022 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964789AbWEBXgk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 19:36:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YtETgqg1Y+b8hqUincZFa05ufezxG2BtMIlvXBwN/lFfkrQN2qm3IDAxkp21DJyhOeSR36jmz2OsH1mmlw/s1IgoI/z93P2sT0jPfGAhX9nu/SdjhTZIAU6fX2AGNQQYUTG3f535OXMz5MUGPc9IINjqWi8p+xcU5BDu024Iwvc=
Message-ID: <21d7e9970605021636x48c178fbgeac85726b8223629@mail.gmail.com>
Date: Wed, 3 May 2006 09:36:38 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com, akpm@osdl.org
In-Reply-To: <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
	 <44578C92.1070403@linux.intel.com>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
	 <1146594457.32045.91.camel@laptopd505.fenrus.org>
	 <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
	 <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com>
	 <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So why don't we just build a VGA class driver or make null fbdev
> drivers? That solution works and stays in the model of one driver per
> device and user space using a device driver to control the hardware.
> This is a known problem and we have a valid solution, why build a new
> API perpetuating the old model? If there wasn't a workable alternative
> available I wouldn't be complaining.

We never have had one device driver for graphics devices, it would be
nice yes, it won't be happening today or tomorrow though, I'm trying
for now to remove as much of the evil crap from X as I can *now* so it
works on certain systems.... I am also however trying to not break
current deployments of systems already out there, the enable thing
allows this, without adding the vga class stuff, I know I'm going to
have to sort this merging of DRM and fb out at some stage, but so far
I've falied 3 times and I hate going back to it,

I'm going to have to force Greg to sit down and do some hacking at OLS
this year, no getting away without fully understanding what we need
(guess what the class changes didn't really help :-)

>
> Have you seen this method of getting root from X?
> http://www.cansecwest.com/slides06/csw06-duflot.ppt
> It is referenced from Theo de Raadt interview on kerneltrap
> http://kerneltrap.org/node/6550
>
> I am happy to see progress being made at getting X out of the PCI bus business.

Yes, and it really isn't a surprise, X is evil, but to be honest
fixing X doesn't fix that problem, it does allow you to fix the OS
more than likely though...

Dave.
