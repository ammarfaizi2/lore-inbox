Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264449AbTCZATd>; Tue, 25 Mar 2003 19:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264494AbTCZATd>; Tue, 25 Mar 2003 19:19:33 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:28824 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264449AbTCZATb>; Tue, 25 Mar 2003 19:19:31 -0500
Subject: Re: 2.5 and modules ?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048636973.1569.20.camel@tiger>
References: <1048564993.2994.13.camel@tiger>
	 <Pine.LNX.4.51.0303251219250.9373@dns.toxicfilms.tv>
	 <1048636973.1569.20.camel@tiger>
Content-Type: text/plain
Organization: 
Message-Id: <1048638632.1176.4.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 26 Mar 2003 01:30:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 01:02, Louis Garcia wrote:
> Setting hostname tiger:                              [  OK  ]
> Initializing USB controller (usb-uhci): FATAL: Module usb_uhci

The USB UHCI module has been renamed. Now it's called uhci-hcd.ko. Make
sure the following line is present in "/etc/modprobe.conf":

alias usb-controller uhci-hcd

>  not found.                                          [ FAILED ]
> Mounting USB filesystem:                             [  OK  ]
> grep: /proc/bus/usb/drivers:  No such file or directory.

No more drivers in /proc/bus/usb.

> Mounting local filesystems:  mount: fs type ntfs not supported by
> kernel.  mount: fs type vfat not supported by kernel.
>                                                      [ FAILED ]
> 
> 
> I have built all required modules:

"cat /proc/sys/kernel/modprobe" should spit:

   /sbin/modprobe

Double check this... I found that rc.sysinit from RH8 and RH9 do
configure this to /sbin/true, thus invalidating dynamic kernel module
loading.

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

