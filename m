Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUCPMA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 07:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUCPMA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 07:00:27 -0500
Received: from mail3.absamail.co.za ([196.35.40.69]:63297 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S261582AbUCPMAP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 07:00:15 -0500
Subject: Re: Re: [2.6.4] USB malfunction on ACPI resume
From: "Niel Lambrechts" <niella@absamail.co.za>
To: len.brown@intel.com
CC: linux-kernel@vger.kernel.org
Date: Tue, 16 Mar 2004 14:07:56 +0200
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1079438876.ce6a7ec0niella@absamail.co.za>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did put some hope on this, even unloaded all modules up to usbcore prior to suspending, but it does not make a difference to the outcome. 

My response to David Brownell contains a kernel-trace which may be useful (I hope).

Thanks,
Niel

-----Original Message-----
From: Len Brown <len.brown@intel.com>
To: Niel Lambrechts <antispam@absamail.co.za>
Date: 16 Mar 2004 02:25:44 -0500
Subject: Re: [2.6.4] USB malfunction on ACPI resume

how about if you remove the ehci_hcd module before suspending?

-Len

On Sun, 2004-03-14 at 16:46, Niel Lambrechts wrote:
> My Thinkpad R50P (Intel 82855PM with Speedstep 1.7GHz) shows the
> following badness when resuming after an ACPI suspend - even if
> hotplug
> and usb modules were never started beforehand: 
> 
> Mar 12 01:22:42 localhost kernel: 0 at 41
> Mar 12 01:22:42 localhost kernel: ehci_hcd 0000:00:1d.7: capability
> d49a4140 at
> 41                                                                   
> Mar 12 01:22:42 localhost last message repeated 1266
> times                 Mar 12 01:22:42 localhost kernel: 0 at
> 41                                  Mar 12 01:22:42 localhost kernel:
> ehci_hcd 0000:00:1d.7: capability d49a4140 at
> 41                                                                    
> times                  Mar 12 01:22:43 localhost kernel: Kernel
> logging
> (proc) stopped by user.
> 
> This is repeated many many times -> CPU usage jumps to 100% (due to
> ehci_hcd module) and klogd becomes very busy with the above nonsense.
> 
> I cannot remove ehci_hcd, any attempt to rmmod will just hang, only
> resolve is to reboot.
> 
> Niel
> 
> 
> Controller:
> -----------
> 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
> 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
> 00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
> 00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01)
> 




