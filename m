Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291020AbSCDCbf>; Sun, 3 Mar 2002 21:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291022AbSCDCbZ>; Sun, 3 Mar 2002 21:31:25 -0500
Received: from q2.herzig.net ([208.0.203.229]:54022 "EHLO Q2.herzig.net")
	by vger.kernel.org with ESMTP id <S291020AbSCDCbO>;
	Sun, 3 Mar 2002 21:31:14 -0500
From: "Kevin Herzig" <Kevin@Herzig.Net>
To: <linux-kernel@vger.kernel.org>
Subject: DAC960 Driver - problem with DAC960PL
Date: Sun, 3 Mar 2002 21:31:12 -0500
Message-ID: <001301c1c324$a70bec60$21fea8c0@cx351466a>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E16heAb-0005cC-00@the-village.bc.nu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Has anyone had any luck getting a DAC960PL card working in a HP Netserver
LS2?

I have recently acquired two of these beasts.  It has 4 Pentium 166
processors,
640Meg Ram, and 6 4GB Quantum SCSI drives.  I've applied the latest firmware
patch (2.73) to the controller and made sure the system's BIOS was up to
date
(relatively speaking).

I downloaded kernel version 2.2.19 from ftp.kernel.org, then overwrote
DAC960.H and DAC960.C with the version found at
http://www.dandelion.com/Linux/DAC960-2.2.11.tar.gz.  The version
of gcc I am using is gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)

The initial Mylex BIOS reads 'DAC960P' although the model printed
on the card and displayed in the raid configuration utility is DAC960PL.  It
is a
model that only has one EEPROM installed.

I built DAC960.o as a module.  I am using Debian 3.0's rescue and root
floppies to boot the system (with my custom kernel added to the rescue
disk).
I start a console, do an insmod DAC960.o,and get the following messages
(retyped):


---------------------------------
DAC960#0: While configuring DAC960 PCI RAID Controller at
DAC960#0: PCI Bus 1 Device 15 Function 0 I/O Address 0xF480 PCI Address
0xFFCFEC00
DAC960#0: ENQUIRY FAILED - DETACHING
---------------------------------

lsmod now shows the module as loaded, but of course the device is not
available.

I have 2 of these beasts with this same controller.  Unfortunately, when the
other controller is installed the insmod hangs the system.  It is still
responsive to keys and will switch consoles, but ignores all inputs.

Both of these cards have been in service for many years until I acquired the
machines last week.  A different OS is currently installed on the array and
is working fine.  I've also cleared the configuration, rebuilt it, and
re-initialized
the array.

Any help would be greatly appreciated.

Thanks,

Kevin




