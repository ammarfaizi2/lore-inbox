Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284421AbRLRSJn>; Tue, 18 Dec 2001 13:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284451AbRLRSJc>; Tue, 18 Dec 2001 13:09:32 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:36619 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284444AbRLRSJU>;
	Tue, 18 Dec 2001 13:09:20 -0500
Date: Tue, 18 Dec 2001 10:06:09 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1 API change summary
Message-ID: <20011218100609.C5273@kroah.com>
In-Reply-To: <20011218031427.GA5990@storm.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011218031427.GA5990@storm.local>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 20 Nov 2001 15:55:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 04:14:27AM +0100, Andreas Bombe wrote:
> 
> 
> 	drivers/usb/hid.h:
> 
> HID class defines and functions added.

These were taken from include/linux/usb.h
No new functions or defines were created.

> 	include/linux/usb.h:
> 
> Yes, there are lots of changes.  I haven't sorted them out yet.

 - Moved the HID specific defines and functions into include/linux/usb.h
 - Added _lots_ of documentation (which involved moving things around to
   be in a more logical order).
 - removed the FILL_BULK_URB_TO and FILL_INT_URB_TO macros as they were
   not being used
 - added the usb_fill_control_urb(), usb_fill_bulk_urb() and
   usb_fill_int_urb() inline functions to be used instead of the
   FILL_*_URB macros.

Hope this helps,

greg k-h
