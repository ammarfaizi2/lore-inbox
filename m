Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291169AbSCHWnq>; Fri, 8 Mar 2002 17:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291088AbSCHWnd>; Fri, 8 Mar 2002 17:43:33 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:33028 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290919AbSCHWna>;
	Fri, 8 Mar 2002 17:43:30 -0500
Date: Fri, 8 Mar 2002 14:35:14 -0800
From: Greg KH <greg@kroah.com>
To: Thomas Winischhofer <tw@webit.com>
Cc: linux-kernel@vger.kernel.org,
        Carl-Johan Kjellander <carljohan@kjellander.com>
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
Message-ID: <20020308223513.GD28541@kroah.com>
In-Reply-To: <3C89273D.28BC97DB@webit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C89273D.28BC97DB@webit.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 08 Feb 2002 18:57:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 10:03:57PM +0100, Thomas Winischhofer wrote:
> Furthermore, the usb driver(s) behave strangely on
> connecting/disconnecting the camera. Sometimes this works flawlessly,
> sometimes I get a lot of USB timeout ("usb_control/bulk_msg: timeout")
> and/or "USBDEVFS_CONTROL failed dev x rqt 128 rq 6 len 490 ret -110"
> messages in the syslog. (Kernel is 2.4.16 and 2.4.18 - no difference)

Try removing /sbin/usbmodules (or renaming it) to see if this problem
goes away.  I have the same problem with some devices too, and am
working on tracking it down.

thanks,

greg k-h
