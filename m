Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264387AbTCYXv3>; Tue, 25 Mar 2003 18:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264389AbTCYXv3>; Tue, 25 Mar 2003 18:51:29 -0500
Received: from mail135.mail.bellsouth.net ([205.152.58.95]:42034 "EHLO
	imf46bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S264387AbTCYXv1>; Tue, 25 Mar 2003 18:51:27 -0500
Subject: Re: 2.5 and modules ?
From: Louis Garcia <louisg00@bellsouth.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51.0303251219250.9373@dns.toxicfilms.tv>
References: <1048564993.2994.13.camel@tiger>
	 <Pine.LNX.4.51.0303251219250.9373@dns.toxicfilms.tv>
Content-Type: text/plain
Organization: 
Message-Id: <1048636973.1569.20.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 25 Mar 2003 19:02:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm on a RH phoebe beta box. I think this is due to my rc.sysinit not
being ready for 2.5 because I have built my nic driver as a module and
it loaded fine. I am not able to load USB modules or ntfs and vfat
modules. This is what I get at startup:


Setting hostname tiger:                              [  OK  ]
Initializing USB controller (usb-uhci): FATAL: Module usb_uhci
 not found.                                          [ FAILED ]
Mounting USB filesystem:                             [  OK  ]
grep: /proc/bus/usb/drivers:  No such file or directory.
Initializing USB HID interface:                      [  OK  ]
Initializing USB Keyboard: FATAL: Module keybdev not found.
                                                     [ FAILED ]
Initializing USB Mouse: FATAL: Module mousedev not found.
                                                     [ FAILED ]

[ some more stuff thats ok ]

Mounting local filesystems:  mount: fs type ntfs not supported by
kernel.  mount: fs type vfat not supported by kernel.
                                                     [ FAILED ]


I have built all required modules:

ls /lib/modules/2.4.66/kernel/drivers/usb/host
uhci-hcd.ko

ls /lib/modules/2.4.66/kernel/fs/fat
fat.ko

ls /lib/modules/2.4.66/kernel/fs/ntfs
ntfs.ko



On Tue, 2003-03-25 at 06:19, Maciej Soltysiak wrote:
> > except modules. I recompiled the modutils package with module-init-tools
> > according to rusty's old modutils package spec. I am able to compile 2.5
> > as modules without any depmod errors but when I boot 2.5 I can't load
> > any.
> What are the error messages?

