Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUJDRiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUJDRiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUJDRiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:38:20 -0400
Received: from susy.kabatnet.waw.pl ([212.244.31.2]:22800 "HELO
	kabatnet.waw.pl") by vger.kernel.org with SMTP id S268339AbUJDRh7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:37:59 -0400
Message-ID: <41618A69.7050706@kabatnet.waw.pl>
Date: Mon, 04 Oct 2004 19:37:45 +0200
From: jurek Ela Tryjarscy <jurekt@kabatnet.waw.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem - install scsi adapter and scanner
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
In my box I have Redhat 9.
I must connect via SCSI Interface Umax Mirage II scanner.
SCSI adapter is Acard AEC-6712TU.

System logs contain:

Oct  4 19:19:05 localhost kernel:    ACARD AEC-671X PCI Ultra/W SCSI-3 
Host Adapter: 0    IO:1000, IRQ:11.
Oct  4 19:19:05 localhost kernel:          ID:  7  Host Adapter
Oct  4 19:19:05 localhost kernel: scsi0 : ACARD AEC-6710/6712/67160 PCI 
Ultra/W/LVD SCSI-3 Adapter Driver V2.6+ac

information.

Driver is atp870u.

My qustion is:
How to install correctly the scanner and the scsi adapter - I must make 
any mistake.
I do:
modprobe sg
modprobe atp870u

[root@localhost scsi]# lsmod
Module                  Size  Used by    Not tainted
atp870u                23856   0  (unused)
sg                     36524   0  (unused)
scsi_mod              107160   2  [atp870u sg]
ide-cd                 35676   0  (autoclean)
cdrom                  33728   0  (autoclean) [ide-cd]
parport_pc             19076   1  (autoclean)
lp                      8996   0  (autoclean)
parport                37056   1  (autoclean) [parport_pc lp]
autofs                 13268   0  (autoclean) (unused)
8139too                18120   1
mii                     3976   0  [8139too]
keybdev                 2976   0  (unused)
mousedev                5492   1
hid                    22148   0  (unused)
input                   5888   0  [keybdev mousedev hid]
usb-uhci               26348   0  (unused)
usbcore                78816   1  [hid usb-uhci]
ext3                   70784   2
jbd                    51892   2  [ext3]

[root@localhost root]# ls  /proc/scsi
atp870u  scsi

[root@localhost scsi]# more  scsi
Attached devices: none

I think it should be also sg directory in  /proc/scsi

[root@localhost root]# sane-find-scanner

 # No SCSI scanners found. If you expected something different, make 
sure that
 # you have loaded a SCSI driver for your SCSI adapter.
 # Also you need support for SCSI Generic (sg) in your operating system.
 # If using Linux, try "modprobe sg".

Can anyone help me ?

Jurek

