Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311867AbSCNXVW>; Thu, 14 Mar 2002 18:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311866AbSCNXVF>; Thu, 14 Mar 2002 18:21:05 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:61317 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S311867AbSCNXUz>; Thu, 14 Mar 2002 18:20:55 -0500
Message-Id: <200203142321.g2ENL1632499@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Greg KH <greg@kroah.com>
Subject: Re: USB-Storage in 2.4.19-pre
Date: Fri, 15 Mar 2002 01:20:49 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203141432.g2EEWL628078@lmail.actcom.co.il> <20020314212505.GA22263@us.ibm.com>
In-Reply-To: <20020314212505.GA22263@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No go. I still get that device not responding (error=-84).
If I understand your patch, disabling hotplug and loading
usb-storage manually shoud work. It isn't. Actually
I believe that it never got to call hotplug.
usbview does not see the device.

I forgot to say. On one of those computers where I do the testing
I have a USB mouse - which is working just fine.

-- Itai

On Thursday 14 March 2002 23:25 pm, Greg KH wrote:
> On Thu, Mar 14, 2002 at 04:32:09PM +0200, Itai Nahshon wrote:
> > I have used usb-storage with stock redhat kernels for some times. That is
> > usable with just few problems. Recently I switched to 2.4.17, and then to
> > 2.4.19-pre1.
> >
> > On the stock redhat kernels (up to the latest update 2.4.9-31) and on
> > 2.4.17  I had to umount the disk before shutdown. Normal shutdown did not
> > unmount the disk cleanly. It looks like the scsi layer lost access to the
> > physical disk - maybe after unmouting of usbdevfs. (even when I unmount
> > the disk I had some scsi errors reported).
> >
> > This problem was fixed with 2.4.19-pre1.
> >
> > Now I'm trying the latest changes. 2.4.19-pre2-ac{3.4} and 2.4.19-pre3
> > and I cannot use usb-storage at all. I get all kind of erros similar to
> > these:
>
> <snip>
>
> Can you try either the patch at:
> 	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101588420909194
>
> Or just renaming your usbmodules binary to something else and see if the
> problem goes away?
>
> The USB initialization timing changed between 2.4.19-pre1 and -pre2,
> fixing a lot of problems with devices that had previously not worked on
> Linux, but worked fine on Windows.  Turned out we were wrong on the
> timing issues :)
>
> Let me know if this helps or not.
>
> thanks,
>
> greg k-h
