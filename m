Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311866AbSCNX0y>; Thu, 14 Mar 2002 18:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311860AbSCNX0c>; Thu, 14 Mar 2002 18:26:32 -0500
Received: from granite.he.net ([216.218.226.66]:58629 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S311868AbSCNX0X>;
	Thu, 14 Mar 2002 18:26:23 -0500
Date: Thu, 14 Mar 2002 15:26:17 -0800
From: Greg KH <greg@kroah.com>
To: Itai Nahshon <nahshon@actcom.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-Storage in 2.4.19-pre
Message-ID: <20020314152617.B3109@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Itai Nahshon <nahshon@actcom.co.il>, linux-kernel@vger.kernel.org
In-Reply-To: <200203141432.g2EEWL628078@lmail.actcom.co.il> <20020314212505.GA22263@us.ibm.com> <200203142321.g2ENL1632499@lmail.actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203142321.g2ENL1632499@lmail.actcom.co.il>; from nahshon@actcom.co.il on Fri, Mar 15, 2002 at 01:20:49AM +0200
X-Operating-System: Linux 2.2.20 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 01:20:49AM +0200, Itai Nahshon wrote:
> No go. I still get that device not responding (error=-84).
> If I understand your patch, disabling hotplug and loading
> usb-storage manually shoud work. It isn't. Actually
> I believe that it never got to call hotplug.
> usbview does not see the device.

No the main problem is that usbmodules starts talking to the device 
before it is initialized properly by the kernel driver, causing both 
programs to get messed up, and then the device is usually in a 
uninitialized state.

> I forgot to say. On one of those computers where I do the testing
> I have a USB mouse - which is working just fine.

Does that mouse work if you plug it into the same port that you are
plugging the drive into?  I have noticed a lot more errors from flaky
hubs with the new code.

thanks,

greg k-h
