Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTIFJnD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 05:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTIFJnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 05:43:03 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:24847 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262763AbTIFJnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 05:43:00 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Date: Sat, 6 Sep 2003 16:01:44 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <200309020139.08248.mhf@linuxmail.org> <200309060932.47136.mhf@linuxmail.org> <20030906054813.GC20197@kroah.com>
In-Reply-To: <20030906054813.GC20197@kroah.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309061601.44440.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 September 2003 13:48, Greg KH wrote:
> On Sat, Sep 06, 2003 at 10:31:19AM +0800, Michael Frank wrote:
> > It's not loaded on boot, but only when needed. The scripts:
> > 
> > usb1)
> >   if [ ! -e /proc/bus/usb ]; then
> >     echo Loading USB
> >     modprobe usbcore
> >     mount -t usbdevfs usbdevfs /proc/bus/usb
> >     modprobe ohci_hcd
> >     modprobe sd_mod
> >     modprobe pl2303 
> >     modprobe lp
> >   fi
> >   ;;
> > 
> > usb0)
> >   echo Unloading USB
> >   rmmod  usb-storage sd_mod scsi-mod
> >   rmmod pl2303 usbserial
> >   rmmod  lp parport
> >   rmmod  ohci_hcd 
> >   umount usbdevfs
> >   rmmod  usbcore
> >   ;;
> > 
> > Perhaps this is too dumb and I should do some checking along the way,
> > however joe user should be unable to oops things up...
> 
> I agree.  Can you add that oops to a new bug at bugzilla.kernel.org?
> 

Yes, will do, and more testing as well.

Regards
Michael

