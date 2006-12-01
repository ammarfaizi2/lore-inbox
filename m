Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031772AbWLAUmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031772AbWLAUmq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031768AbWLAUmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:42:46 -0500
Received: from foo.birdnet.se ([213.88.146.6]:54422 "EHLO foo.birdnet.se")
	by vger.kernel.org with ESMTP id S1031772AbWLAUmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:42:45 -0500
Message-ID: <20061201204249.28842.qmail@cdy.org>
Date: Fri, 1 Dec 2006 21:42:49 +0100
From: Peter Stuge <stuge-linuxbios@cdy.org>
To: Greg KH <gregkh@suse.de>
Cc: "Lu, Yinghai" <yinghai.lu@amd.com>,
       Stefan Reinauer <stepan@coresystems.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	"Lu, Yinghai" <yinghai.lu@amd.com>,
	Stefan Reinauer <stepan@coresystems.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linuxbios@linuxbios.org, linux-kernel@vger.kernel.org
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com> <20061201191916.GB3539@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201191916.GB3539@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 11:19:16AM -0800, Greg KH wrote:
> Well, earlyprintk will not work, as you need PCI up and running.

Not all of it though. LinuxBIOS will probably do just enough PCI
setup to talk to the EHCI controller and use the debug port _very_
soon after power on.


> And I have some code that barely works for this already, perhaps
> Eric and I should work together on this :)

I would be interested in having a look at any code for it too.


> Yes, that will work just fine today using the usb-serial generic
> driver.

Ugh. I did not know it was that generic. The irony is that I always
ask other libusb users to check the kernel drivers to see if they
really need to write a libusb app.


> I'll knock up a "real" driver for the device later today and send
> it to Linus, as it's trivial to do so, and will make it simpler
> than using the module parameters.

Awesome. Thanks!


//Peter
