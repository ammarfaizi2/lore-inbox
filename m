Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSIAAsM>; Sat, 31 Aug 2002 20:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSIAAsL>; Sat, 31 Aug 2002 20:48:11 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:34566 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318067AbSIAAsL>;
	Sat, 31 Aug 2002 20:48:11 -0400
Date: Sat, 31 Aug 2002 17:51:24 -0700
From: Greg KH <greg@kroah.com>
To: Tony Hoyle <tmh@nothing-on.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in pl2303 driver
Message-ID: <20020901005124.GA15259@kroah.com>
References: <3D7117D3.5080100@nothing-on.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D7117D3.5080100@nothing-on.tv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 08:24:03PM +0100, Tony Hoyle wrote:
> I've just acquired a USB datacable for my phone which appears to have a 
> PL2303 chipset in it (at least that's what hotplug loaded when I plugged 
> it in).  However this driver doesn't appear to work...  No data is 
> transferred and when the software (gnokii) gives up I get an oops:
> 
> Aug 31 20:05:31 spock kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000014
> Aug 31 20:05:31 spock kernel: d48a1344
> Aug 31 20:05:31 spock kernel: *pde = 0d5e3067
> Aug 31 20:05:31 spock kernel: Oops: 0000
> Aug 31 20:05:31 spock kernel: CPU:    0
> Aug 31 20:05:31 spock kernel: EIP: 
> 0010:[usbmouse:__insmod_usbmouse_O/lib/modules/2.4.20-pre5/kernel/drivers/+-302268/96] 

I'm guessing thie is 2.4.20-pre5?  If so can you try the following two
patches that I just sent off to Marcelo:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-usbserial-2.4.20-pre5.patch
and
	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-pl2303-2.4.20-pre5.patch

and let me know if that solves the problem for you or not?

thanks,

greg k-h
