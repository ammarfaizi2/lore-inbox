Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292423AbSCIHTI>; Sat, 9 Mar 2002 02:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292444AbSCIHRV>; Sat, 9 Mar 2002 02:17:21 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292473AbSCIHPF>;
	Sat, 9 Mar 2002 02:15:05 -0500
Message-ID: <3C8985B5.4D3606C7@webit.com>
Date: Sat, 09 Mar 2002 04:47:01 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org,
        Carl-Johan Kjellander <carljohan@kjellander.com>
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
In-Reply-To: <3C89273D.28BC97DB@webit.com> <20020308223513.GD28541@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> On Fri, Mar 08, 2002 at 10:03:57PM +0100, Thomas Winischhofer wrote:
> > Furthermore, the usb driver(s) behave strangely on
> > connecting/disconnecting the camera. Sometimes this works flawlessly,
> > sometimes I get a lot of USB timeout ("usb_control/bulk_msg: timeout")
> > and/or "USBDEVFS_CONTROL failed dev x rqt 128 rq 6 len 490 ret -110"
> > messages in the syslog. (Kernel is 2.4.16 and 2.4.18 - no difference)
> 
> Try removing /sbin/usbmodules (or renaming it) to see if this problem
> goes away.  I have the same problem with some devices too, and am
> working on tracking it down.

This actually made it, thanks so far! (usbmodules is located in
/usr/sbin/ on my machine)

Of course, the main problem still exists. Additionally, the USB audio
module is not loaded any more (for the built-in microphone of this
camera).

Sorry if I ask something stupid, I am a total USB rookie - what's that
/usr/sbin/usbmodules file for?

Thomas


-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com                  *** http://www.webit.com/tw
