Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSEUUAX>; Tue, 21 May 2002 16:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSEUUAX>; Tue, 21 May 2002 16:00:23 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:5126 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316578AbSEUUAV>;
	Tue, 21 May 2002 16:00:21 -0400
Date: Tue, 21 May 2002 12:59:25 -0700
From: Greg KH <greg@kroah.com>
To: "Maksim \(Max\) Krasnyanskiy" <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel ?
Message-ID: <20020521195925.GA2623@kroah.com>
In-Reply-To: <5.1.0.14.2.20020521122422.06b21188@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 23 Apr 2002 18:30:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 12:41:39PM -0700, Maksim (Max) Krasnyanskiy wrote:
> Greg,
> 
> I'm gonna speak for Bluetooth USB devices.
> I do have bunch of things like Kodak digi camera, Sony DV camcorder, CF 
> reader, etc. But they don't
> seem to care much about which HCD is used and work equally well with both 
> usb-uhci and uhci drivers.
> 
> I used to be a uhci driver fan :). But starting somewhere from 2.4.16 or so 
> Bluetooth devices work much better
> with usb-uhci driver (not all devices but most of them). Even thought 
> Bluetooth is pretty slow (about 700kbps)
> performance difference is sometimes pretty significant 20-30% (ie usb-uhci 
> driver is faster).
> 
> So basically I vote for usb-uhci. However some things will have to be 
> fixed. We (Bluetooth folks) have couple
> of devices that refuse to work with usb-uhci (I didn't test the latest 
> usb-uhci though).

Sorry for the confusion, but both usb-uhci.c and uhci.c will be deleted
anyway :)

I am more interested in usb-uhci-hcd.c and uhci-hcd.c drivers, which both
showed up in 2.5.16.  Yes they are based on the previous usb-uhci.c and
uhci.c drivers respectivly, but they are a bit different (they use the
hcd core code which reduces the size of the driver.)

You also might want to check out uhci.c again in 2.4.19-pre.  It has had
a lot of previous bugs fixed and works _much_ better for me than before.

thanks,

greg k-h
