Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVANPAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVANPAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 10:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVANPAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 10:00:03 -0500
Received: from bromo.msbb.uc.edu ([129.137.3.146]:8608 "HELO bromo.msbb.uc.edu")
	by vger.kernel.org with SMTP id S262004AbVANO77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:59:59 -0500
To: linux-kernel@vger.kernel.org
Subject: usb key oddities with 2.6.10-ac9
Message-Id: <20050114145837.6AB211DC357@bromo.msbb.uc.edu>
Date: Fri, 14 Jan 2005 09:58:37 -0500 (EST)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     Is anyone else seeing problems with kernel 2.6.10 and usb keys
under the Gnome desktop? Fedora Core 2 and 3 has just had two kernel
updates to 2.6.10 (using the -ac8 and -ac9 patches respectively). In
each case, the updates seem to have broken the ability of the Gnome
desktop to present a Flash icon when a usb key is inserted. Oddly if
one boots the machine with the flash key inserted, the Flash icon
does appear in the Gnome desktop's Computer folder. However if one
removes and reinserts the key it disappears and doesn't come back.
I see the same kernel messages as I did under 2.6.7 when I insert
the memory key...

Jan 11 15:18:30 graphics kernel:   Vendor: LEXAR     Model: JUMPDRIVE SECURE  Rev: 2000
Jan 11 15:18:30 graphics kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Jan 11 15:18:30 graphics kernel: SCSI device sdd: 1010784 512-byte hdwr sectors
(518 MB)
Jan 11 15:18:30 graphics kernel: sdd: assuming drive cache: write through
Jan 11 15:18:30 graphics kernel: SCSI device sdd: 1010784 512-byte hdwr sectors
(518 MB)
Jan 11 15:18:30 graphics kernel: sdd: assuming drive cache: write through
Jan 11 15:18:31 graphics kernel:  sdd: sdd1
Jan 11 15:18:31 graphics kernel: Attached scsi disk sdd at scsi3, channel 0, id
0, lun 0
Jan 11 15:18:31 graphics kernel: Attached scsi generic sg3 at scsi3, channel 0,
id 0, lun 0,  type 0
Jan 11 15:18:31 graphics scsi.agent[5979]: disk at /devices/pci0000:00/0000:00:1d.7/usb1/1-5/1-5:1.0/host3/target3:0:0/3:0:0:0

and if I add a line to fstab such as...
                                   
/dev/sdd1    /mnt/lexar    vfat             noauto,rw,user 0 0
                                                              
I can manually mount the usb key fine. Do you know if any other distros
are seeing this problem with 2.6.10 or if the breakage is likely specific
to Fedora's kernel builds?
                       Jack
