Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbSAGSl6>; Mon, 7 Jan 2002 13:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285065AbSAGSlt>; Mon, 7 Jan 2002 13:41:49 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:5899 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285023AbSAGSlo>;
	Mon, 7 Jan 2002 13:41:44 -0500
Date: Mon, 7 Jan 2002 10:39:48 -0800
From: Greg KH <greg@kroah.com>
To: Dylan Egan <crack_me@bigpond.com.au>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.4.17 - hanging due to usb
Message-ID: <20020107183948.GJ7378@kroah.com>
In-Reply-To: <5.1.0.14.0.20020107132332.00b564a8@mail.bigpond.com> <5.1.0.14.0.20020107121314.00ba4258@mail.bigpond.com> <5.1.0.14.0.20020107121314.00ba4258@mail.bigpond.com> <5.1.0.14.0.20020107132332.00b564a8@mail.bigpond.com> <5.1.0.14.0.20020107163253.00b48790@mail.bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.0.20020107163253.00b48790@mail.bigpond.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 10 Dec 2001 15:13:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 04:43:47PM +1100, Dylan Egan wrote:
> 
> >Can you not load the usb-storage driver, load the usbcore module, and
> >the USB host driver that you are using, and point hotplug to somewhere
> >else:
> >        echo /bin/true > /proc/sys/kernel/hotplug
> >
> >Then plug in your device, and send the output of /proc/bus/usb/devices
> >to the list (and the linux-usb-devel list, which is a better place for
> >this :)
> 
> I only got this extra bit of infomation from the way you said for me to do 
> it.
> When i loaded usbcore this time it said cant get major 180 for usb....
> Ok i loaded it as you said it all went find but it never gave me anything 
> when i went to do "cat /proc/bus/usb/devices".

Oops, forgot to tell you to mount usbdevfs.  Try these steps then:

  insmod usbcore
  mount -t usbdevfs none /proc/bus/usb
  insmod usb-uhci
  {plug in device}
  cat /proc/bus/usb/devices


thanks,

greg k-h
