Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314518AbSDSCfE>; Thu, 18 Apr 2002 22:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314517AbSDSCdh>; Thu, 18 Apr 2002 22:33:37 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:14085 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314518AbSDSCc4>;
	Thu, 18 Apr 2002 22:32:56 -0400
Date: Thu, 18 Apr 2002 18:31:47 -0700
From: Greg KH <greg@kroah.com>
To: Michael West <neovorbis@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug in USB or HID on asus mobo with via kt266 a chipset
Message-ID: <20020419013147.GA9079@kroah.com>
In-Reply-To: <3CBF5272.3030203@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 21 Mar 2002 23:25:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 07:10:42PM -0400, Michael West wrote:
>    I recently changed motherboards on my linux box and one of my hid 
> controllers (a psx-usb converter) stopped functioning correctly.  I was 
> running a 2.4.18 kernel on both boards, and with the new asus board, 
> apps reading from the /dev/input/js0 file seem to halt after the first 
> 19 joystick messages are read.  I tried reproducing the problem on other 
> kernel versions, and experienced the same problem with a smattering of 
> previous kernels.  I'm using a hid mouse, as well as another hid 
> controller, and both work correctly.  Not sure if its related or not, 
> but I also seem to have some apparent irq problems, as newly plugged in 
> usb devices (any) and by that I mean after the usb-uhci or uhci driver 
> is loaded, throw "USB device not accepting new address - * (error = 
> -110)" errors.  The situation in 2.4.19-pre2 changed a bit by completely 
> breaking the psx-converter (joydev driver assigns no device) only on 
> usb-uhci.  pre3 has the same origional problem, as well as 4 and 5. 
> Pre6 and Pre7 seem to completely break all usb hid devices.  The irq 
> (or whatever) problems go away and devices are hotplugged fine, but no 
> hid devices are ever registered.  Sorry for my infamiliarity with the 
> linux kernel source and terminology.  Thanks in advance.

What is your .config for -pre7?  And what does the kernel log say when
your devices are recognized.  And what does /proc/bus/usb/devices say
when your devices are plugged in?

thanks,

greg k-h
