Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUAJXZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 18:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUAJXZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 18:25:26 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:37645 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S265500AbUAJXZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 18:25:24 -0500
To: kweelist@xs4all.nl
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1AfR8E-0000HN-00@toba.home> (message from Roland Kwee on Sat,
	10 Jan 2004 22:58:58 +0100)
Subject: Re: Sony DSC-F505V USB broken in linux-2.6.0
Reply-to: Roland Kwee <kweelist@xs4all.nl>
References: <E1AfR8E-0000HN-00@toba.home>
Message-Id: <E1AfSR2-0000Kf-00@toba.home>
From: Roland Kwee <roland@tesla.xs4all.nl>
Date: Sun, 11 Jan 2004 00:22:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry having bothered list readers, but this problem is fixed with 2.6.1.
Apologies.
Before I posted, I did notice the release of 2.6.1, read the release notes,
but saw nothing related to the Sony camera, and went ahead with the posting.

Keep up the good works!

Roland Kwee

> Date: Sat, 10 Jan 2004 22:58:58 +0100
> 
> Problem
> =======
> 
> After upgrading from linux-2.4.21 to 2.6.0,
> my camera Sony DSC-F505V doesn't connect anymore.
> 
> What I tried myself
> ===================
> 
> I had to change a module name: usb-uhci    (2.4.21) --> uhci-hcd    (2.6.0),
> and a hyphen:                  usb-storage (2.4.21) --> usb_storage (2.6.0)
> 
> I noticed that the F505 entry in unusual_devs.h changed in 2.6.0.
> I fooled around with this a bit without seeing an improvement.
> 
> What does work
> ==============
> 
> The usb-storage part seems to work. See /var/log/message:
> 
> kernel: scsi0 : SCSI emulation for USB Mass Storage devices
> kernel:   Vendor: Sony      Model: Sony DSC          Rev: 2.10
> kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
> kernel: SCSI device sda: 126848 512-byte hdwr sectors (65 MB)
> 
> What is still missing
> =====================
> 
> What is missing in 2.6.0 is the 2.4.21 log message:
> 
>    Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> 
> Accordingly, 'mount' will fail with 'not a valid block device'.
> 
> Any help is appreciated. Thanks in advance!
> Regards, Roland Kwee    (CC: to kweelist@xs4all.nl is appreciated)

