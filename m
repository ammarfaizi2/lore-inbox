Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291026AbSCDCuH>; Sun, 3 Mar 2002 21:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291041AbSCDCtp>; Sun, 3 Mar 2002 21:49:45 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:62188
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S291026AbSCDCtk>; Sun, 3 Mar 2002 21:49:40 -0500
Date: Sun, 3 Mar 2002 21:57:01 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Kevin Herzig <Kevin@Herzig.Net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DAC960 Driver - problem with DAC960PL
Message-ID: <20020303215700.B3997@animx.eu.org>
In-Reply-To: <E16heAb-0005cC-00@the-village.bc.nu> <001301c1c324$a70bec60$21fea8c0@cx351466a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <001301c1c324$a70bec60$21fea8c0@cx351466a>; from Kevin Herzig on Sun, Mar 03, 2002 at 09:31:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Has anyone had any luck getting a DAC960PL card working in a HP Netserver
> LS2?

DAC960PL?  yes, friend of mine did that, but not on an hp netserver.  His
machine is an AT&T dual p166.  He's using it with the original firmware of
2.39.  We modified the DAC960.c so that it doesn't check firmware (no
problems tho)  The only thing is that he's using kernel 2.4.17

I'm running both a DAC960PD and PDU (2 ch) in a DEC alpha.  I boot from the
PD with a RAID0 and I have a RAID5 on the PDU with 6 disks.  It's a screwy
configuration, but it works.

> I have recently acquired two of these beasts.  It has 4 Pentium 166
> processors,
> 640Meg Ram, and 6 4GB Quantum SCSI drives.  I've applied the latest firmware
> patch (2.73) to the controller and made sure the system's BIOS was up to
> date
> (relatively speaking).
> 
> I downloaded kernel version 2.2.19 from ftp.kernel.org, then overwrote
> DAC960.H and DAC960.C with the version found at
> http://www.dandelion.com/Linux/DAC960-2.2.11.tar.gz.  The version
> of gcc I am using is gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)
> 
> The initial Mylex BIOS reads 'DAC960P' although the model printed
> on the card and displayed in the raid configuration utility is DAC960PL.  It
> is a
> model that only has one EEPROM installed.
> 
> I built DAC960.o as a module.  I am using Debian 3.0's rescue and root
> floppies to boot the system (with my custom kernel added to the rescue
> disk).
> I start a console, do an insmod DAC960.o,and get the following messages
> (retyped):
> 
> 
> ---------------------------------
> DAC960#0: While configuring DAC960 PCI RAID Controller at
> DAC960#0: PCI Bus 1 Device 15 Function 0 I/O Address 0xF480 PCI Address
> 0xFFCFEC00
> DAC960#0: ENQUIRY FAILED - DETACHING
> ---------------------------------
> 
> lsmod now shows the module as loaded, but of course the device is not
> available.
> 
> I have 2 of these beasts with this same controller.  Unfortunately, when the
> other controller is installed the insmod hangs the system.  It is still
> responsive to keys and will switch consoles, but ignores all inputs.
> 
> Both of these cards have been in service for many years until I acquired the
> machines last week.  A different OS is currently installed on the array and
> is working fine.  I've also cleared the configuration, rebuilt it, and
> re-initialized
> the array.
> 
> Any help would be greatly appreciated.
> 
> Thanks,
> 
> Kevin
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
