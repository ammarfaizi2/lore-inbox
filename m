Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262043AbSIYSLC>; Wed, 25 Sep 2002 14:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSIYSLC>; Wed, 25 Sep 2002 14:11:02 -0400
Received: from 62-190-218-220.pdu.pipex.net ([62.190.218.220]:55813 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262043AbSIYSLB>; Wed, 25 Sep 2002 14:11:01 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209251824.g8PIOFg0003491@darkstar.example.net>
Subject: Re: HOT SWAP PROBLEM using hp4100 server series
To: devel@qnet.ro (Alex)
Date: Wed, 25 Sep 2002 19:24:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209241350.50702.devel@qnet.ro> from "Alex" at Sep 24, 2002 01:50:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I need some help to test HOT SWAP feature for this drives. I read some 
> documentation and i saw that HOT SWAP may work if my driver for 
> scsi-controller support re-scanning the bus.
> 
> 
> [snip]
> Normal SCSI hardware is not hot-swappable either. It may however work. 
> If your SCSI driver supports re-scanning the bus, and removing and 
> appending devices, you may be able to hot-swap devices.
> 
> 
> I try to check if this feature works for me and don`t. If i remove any 
> scsi drive, this device remain in /proc until will be removed manually, 
> or using a script named rescan-scsi-bus.sh which i found it on google.
> 
> 
> I try to obtain some additional info and i saw that for my 
> scsi-controller has 2 active drivers: one older named sym53cxx.o and 
> one newer named sym53cxx_2.o!
> I don`t have for the moment access to this computer but i remember that 
> on default installation, redhat assigned the old driver to my 
> scsi-controller.
> 
> 
> I want to know if i change the driver with this new one, i can use the 
> HOT SWAP feature!
> 
> 
> Are necessary additional settings to be made when i load the new driver 
> or on the system configuration?
> 
> 
> Any success story will be appreciated.

Why do you want to hot swap disks on a SCSI bus which isn't designed for hot swapping?

There is no guarantee that you could keep the server running in the event of a disk failiure - a faulty disk *could* take the whole bus down with it, (it shouldn't do, but you can't guarantee it), so if you are trying to do this to improve reliability, you might be better off looking at using hot spare disks instead.

John.
