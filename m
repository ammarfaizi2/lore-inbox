Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263744AbUCPJa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 04:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263746AbUCPJa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 04:30:59 -0500
Received: from fmr06.intel.com ([134.134.136.7]:44753 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263744AbUCPJav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 04:30:51 -0500
Subject: Re: [2.6.4] USB malfunction on ACPI resume
From: Len Brown <len.brown@intel.com>
To: Niel Lambrechts <antispam@absamail.co.za>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F5223@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F5223@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079421944.2400.76.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Mar 2004 02:25:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


