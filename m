Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTADRqt>; Sat, 4 Jan 2003 12:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266984AbTADRqt>; Sat, 4 Jan 2003 12:46:49 -0500
Received: from ns.cef.org.tw ([61.59.38.18]:31249 "EHLO cef.org.tw")
	by vger.kernel.org with ESMTP id <S266981AbTADRqr>;
	Sat, 4 Jan 2003 12:46:47 -0500
Date: Sun, 5 Jan 2003 01:55:20 +0800 (CST)
From: <yoda@cef.org.tw>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 DVD Driver problem !?
Message-ID: <Pine.LNX.4.21.0301050154270.2520-100000@mailhost.cef.org.tw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Environment:
VIA Chipset vt82c686b
320MB RAM
AMD Duron 750
/proc/modules:
nvidia               1593984  10
nls_cp437               5148   3 (autoclean)

hda: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdb: QUANTUM FIREBALLlct10 15, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-ROM drive
hdd: ASUS DVD-ROM E608, ATAPI CD/DVD-ROM drive

Kernel version : 2.4.20

Trouble software : xine,mplayer,ogle

Problem describe:

After I compiled kernel 2.4.20 , I found the DVD-rom action is something
strange !
First , I used it to play game .... work fine no trouble happen, the game
CD is in CDROM type of course.
Then I download xine-1.0.0-beta1 and compile it, it works perfectly except
DVD vedio playing.
When I play an DVD-vedio , it failed to read correctly and put log in
/var/log/messages as below.

Jan  4 01:44:30 localhost kernel: hdd: command error: error=0x54
Jan  4 01:44:30 localhost kernel: end_request: I/O error, dev 16:40 (hdd),
sector 2077592
Jan  4 01:44:30 localhost kernel: hdd: command error: status=0x51 {
DriveReady SeekComplete Error }
Jan  4 01:44:30 localhost kernel: hdd: command error: error=0x54
Jan  4 01:44:30 localhost kernel: hdd: command error: status=0x51 {
DriveReady SeekComplete Error }

I tried use hdparm to turn off the dma support on /dev/hdd ( The DVD drive
) ,I successful turn off the dma support.
But, it did'nt change any thing !
So , I download kernel 2.4.18 ,because I remeber that I can play DVD vedio
under this version.
As I compiled and lilo it then I reboot my PC.
Ok ! Now I play DVD vedio using the same version xine, the difference is
the kernel version is 2.4.18.
Xine works perfectly, I can play DVD vedio on my PC again !

Below is my Configuration of 2.4.18 at "IDE, ATA and ATAPI Block
devices" part :
<*>   Include IDE/ATA-2 DISK support
[*]     Use multi-mode by default
<*>   Include IDE/ATAPI CDROM support
< >   Include IDE/ATAPI TAPE support
< >   Include IDE/ATAPI FLOPPY support
<*>   SCSI emulation support
--- IDE chipset support/bugfixes                                       
[ ]   CMD640 chipset bugfix/support                                 
[ ]   ISA-PNP EIDE support
[ ]   RZ1000 chipset bugfix/support                                 
[*]   Generic PCI IDE chipset support
[*]     Sharing PCI IDE interrupts support                          
[*]     Generic PCI bus-master DMA support
[ ]     Boot off-board chipsets first support                       
[*]       Use PCI DMA by default when available                     
[ ]       ATA Work(s) In Progress (EXPERIMENTAL)                    
:
: I don't choose
:
[*]     VIA82CXXX chipset support

And below is the Configuration of 2.4.20 at "IDE, ATA and ATAPI Block
devices" part :
<*>   Include IDE/ATA-2 DISK support
[*]     Use multi-mode by default
[ ]     Auto-Geometry Resizing support
<*>   Include IDE/ATAPI CDROM support
< >   Include IDE/ATAPI TAPE support
< >   Include IDE/ATAPI FLOPPY support
<*>   SCSI emulation support
[*]   IDE Taskfile Access( No effect ! I had tried )
--- IDE chipset support/bugfixes                                       
[ ]   CMD640 chipset bugfix/support                                 
[ ]   ISA-PNP EIDE support
[ ]   RZ1000 chipset bugfix/support                                 
[*]   Generic PCI IDE chipset support
[*]     Sharing PCI IDE interrupts support                          
[*]     Generic PCI bus-master DMA support
[ ]     Boot off-board chipsets first support                       
[*]       Use PCI DMA by default when available                     
[*]     Enable DMA only for disks( No effect ! I had tried )
[ ]       ATA Work(s) In Progress (EXPERIMENTAL)                    
:
: I don't choose
:
[*]     VIA82CXXX chipset support

These are the informations I could offer, if you need more details ,
please tell me.
I am willing to assist you to solve this problem.
You are doing very great works, I am appreciate your works very much !
May God bless this work !


