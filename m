Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262852AbRE0SNq>; Sun, 27 May 2001 14:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262853AbRE0SNg>; Sun, 27 May 2001 14:13:36 -0400
Received: from ace.ulyssis.student.kuleuven.ac.be ([193.190.253.36]:63751 "EHLO
	ace.ulyssis.org") by vger.kernel.org with ESMTP id <S262852AbRE0SNY>;
	Sun, 27 May 2001 14:13:24 -0400
Date: Sun, 27 May 2001 20:00:02 +0200
From: Pieter Barrezeele <macbar@ulyssis.org>
To: jerdfelt@valinux.com, linux-kernel@vger.kernel.org
Subject: usb-ohci module from 2.4.5 kernel refuses to load on alpha, usb-ohci in a monolithic kernel refuses to recognize devices
Message-ID: <20010527200002.E2244@ace.ulyssis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having the following problem, when trying to load usb-ohci as a module:

        firmin:/usr/src/linux/drivers/usb# modprobe usb-ohci
        /lib/modules/2.4.5/kernel/drivers/usb/usb-ohci.o: init_module: No such device
        Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
        /lib/modules/2.4.5/kernel/drivers/usb/usb-ohci.o: insmod /lib/modules/2.4.5/kernel/drivers/usb/usb-ohci.o failed
        /lib/modules/2.4.5/kernel/drivers/usb/usb-ohci.o: insmod usb-ohci failed
        firmin:/usr/src/linux/drivers/usb#

Compiling this into the kernel doesn't seem to solve the problem as the bootstrap mentions:
        usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS settings!

When browsing through arch/alpha/kernel/sys_miata.c, it seemed to me that there
are no irq assignments to the usb subsystem.

Off the record, my system is a Digital Personal Workstation 500au. If you need more specs, do not hesitate to ask.

Pieter.


------------------------------------------------------------------------------
Pieter Barrezeele                                           macbar@ulyssis.org 
2e Lic Informatica KULeuven                Ulyssis sysadmin, Linux enthousiast

Build a system even a fool can use, and only a fool will want to use it ...  


------------------------------------------------------------------------------
