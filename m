Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbRL0DCW>; Wed, 26 Dec 2001 22:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285634AbRL0DCN>; Wed, 26 Dec 2001 22:02:13 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:26382 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285498AbRL0DBx>;
	Wed, 26 Dec 2001 22:01:53 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Greg KH <greg@kroah.com>
Cc: Guido Guenther <agx@sigxcpu.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17]: oops in usbcore during suspend 
In-Reply-To: Your message of "Wed, 26 Dec 2001 10:03:53 -0800."
             <20011226100353.D3460@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Dec 2001 14:01:39 +1100
Message-ID: <11170.1009422099@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2001 10:03:53 -0800, 
Greg KH <greg@kroah.com> wrote:
>On Wed, Dec 26, 2001 at 06:00:21PM +0100, Guido Guenther wrote:
>> Call Trace: [usbcore:usb_devfs_handle_Re9c5f87f+174345/197882743] [usbcore:usb_devfs_handle_Re9c5f87f+174855/197882233] [pci_pm_suspend_device+32/36] [pci_pm_suspend_bus+82/104] [pci_pm_suspend+35/68] 
>
>These aren't valid symbols :)
>It looks like something is messing with your oops output before you run
>it through ksymoops.  Can you take the raw values from 'dmesg'?

Looks like the completely broken code in klogd, I do not understand why
distributors still ship with it turned on.  Always run klogd as klogd -x,
change /etc/rc.d/init.d/syslogd, restart syslogd and reproduce the
problem.

