Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311800AbSCNVai>; Thu, 14 Mar 2002 16:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311798AbSCNVaY>; Thu, 14 Mar 2002 16:30:24 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15510 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311813AbSCNV3l>;
	Thu, 14 Mar 2002 16:29:41 -0500
Date: Thu, 14 Mar 2002 13:25:05 -0800
From: Greg KH <greg@kroah.com>
To: Itai Nahshon <nahshon@actcom.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-Storage in 2.4.19-pre
Message-ID: <20020314212505.GA22263@us.ibm.com>
In-Reply-To: <200203141432.g2EEWL628078@lmail.actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203141432.g2EEWL628078@lmail.actcom.co.il>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.5.7-pre1 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 04:32:09PM +0200, Itai Nahshon wrote:
> I have used usb-storage with stock redhat kernels for some times. That is usable
> with just few problems. Recently I switched to 2.4.17, and then to 2.4.19-pre1.
> 
> On the stock redhat kernels (up to the latest update 2.4.9-31) and on 2.4.17  I had to
> umount the disk before shutdown. Normal shutdown did not unmount the disk cleanly.
> It looks like the scsi layer lost access to the physical disk - maybe after unmouting
> of usbdevfs. (even when I unmount the disk I had some scsi errors reported).
> 
> This problem was fixed with 2.4.19-pre1.
> 
> Now I'm trying the latest changes. 2.4.19-pre2-ac{3.4} and 2.4.19-pre3 and I cannot
> use usb-storage at all. I get all kind of erros similar to these:

<snip>

Can you try either the patch at:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101588420909194

Or just renaming your usbmodules binary to something else and see if the
problem goes away?

The USB initialization timing changed between 2.4.19-pre1 and -pre2,
fixing a lot of problems with devices that had previously not worked on
Linux, but worked fine on Windows.  Turned out we were wrong on the
timing issues :)

Let me know if this helps or not.

thanks,

greg k-h
