Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVECW31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVECW31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVECW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:29:27 -0400
Received: from web21124.mail.yahoo.com ([216.136.227.189]:7000 "HELO
	web21124.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261868AbVECW15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:27:57 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=VbekMyunqAtH7lLKJoStp/8LvhJdP8CgEdx+fUBrvUJBLBQpSt74Wsx/Pcsf7sBysaxaHnSyIeXR4ZsMl/qmJvH0SeszFI3Q66FwwF2GGyQHua8KSWH/pjYWNx9FleBHSOknLz+J0EdHTExZ4uHMG/fwfo/iPWIuOt0x2rBiCEk=  ;
Message-ID: <20050503222749.42151.qmail@web21124.mail.yahoo.com>
Date: Tue, 3 May 2005 15:27:49 -0700 (PDT)
From: segin <segin11@yahoo.com>
Subject: Re: zImage on 2.6?
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wakko Warner <wakko@animx.eu.org>
In-Reply-To: <20050503221922.GC12199@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be honest. zImage kernels are pointless, and are _BIGGER_ than a bzImage kernel.

You should realize that use of zImage kernels detucts 100 points off your IQ.

--- Wakko Warner <wakko@animx.eu.org> wrote:

> Randy.Dunlap wrote:
> > On Tue, 3 May 2005 12:33:43 -0400 Wakko Warner wrote:
> > | Yes, I do recall it says "System is 724k".  zImage failes.  bzImage says
> > | 724k as well and succeeds.
> > 
> > The image size needs to be <= 0x7f000 (520192 bytes, 508 KB).
> > 
> > (No, I don't know why, just that this is what is being
> > enforced.)
> > 
> > Just cut more out of the kernel image...
> 
> Any suggestions?  All that I know of that is modularizable is a module,
> except for keyboard, ext2, unix sockets, ramdisk+initrd.  Some of the options I need since
> this is supposed to support all relevent hardware that we use where I work.
> (all scsi,ide,sata,raid cards,ethernet cards that we have)
> 
> Hmm, I did find one I forgot.  CONFIG_MII.
> 
> Here's my =y config:
> X86=y
> MMU=y
> UID16=y
> GENERIC_ISA_DMA=y
> GENERIC_IOMAP=y
> EXPERIMENTAL=y
> CLEAN_COMPILE=y
> BROKEN_ON_SMP=y
> SYSCTL=y
> HOTPLUG=y
> EMBEDDED=y
> TINY_SHMEM=y
> MODULES=y
> MODULE_UNLOAD=y
> MODULE_FORCE_UNLOAD=y
> OBSOLETE_MODPARM=y
> KMOD=y
> X86_PC=y
> M586=y
> X86_CMPXCHG=y
> X86_XADD=y
> RWSEM_XCHGADD_ALGORITHM=y
> GENERIC_CALIBRATE_DELAY=y
> X86_PPRO_FENCE=y
> X86_F00F_BUG=y
> X86_WP_WORKS_OK=y
> X86_INVLPG=y
> X86_BSWAP=y
> X86_POPAD_OK=y
> X86_ALIGNMENT_16=y
> NOHIGHMEM=y
> PM=y
> ACPI=y
> ACPI_BOOT=y
> ACPI_INTERPRETER=y
> ACPI_BUS=y
> ACPI_EC=y
> ACPI_POWER=y
> ACPI_PCI=y
> ACPI_SYSTEM=y
> PCI=y
> PCI_GOANY=y
> PCI_BIOS=y
> PCI_DIRECT=y
> PCI_MMCONFIG=y
> ISA=y
> CARDBUS=y
> PCMCIA_PROBE=y
> BINFMT_ELF=y
> STANDALONE=y
> PREVENT_FIRMWARE_BUILD=y
> PNP=y
> ISAPNP=y
> BLK_DEV_RAM=y
> BLK_DEV_INITRD=y
> IOSCHED_NOOP=y
> IDEDISK_MULTI_MODE=y
> BLK_DEV_IDEPCI=y
> IDEPCI_SHARE_IRQ=y
> BLK_DEV_IDEDMA_PCI=y
> IDEDMA_PCI_AUTO=y
> BLK_DEV_IDEDMA=y
> IDEDMA_AUTO=y
> SCSI_PROC_FS=y
> AIC7XXX_DEBUG_ENABLE=y
> AIC7XXX_REG_PRETTY_PRINT=y
> AIC79XX_DEBUG_ENABLE=y
> AIC79XX_REG_PRETTY_PRINT=y
> MEGARAID_NEWGEN=y
> SCSI_SATA=y
> NET=y
> INET=y
> NETDEVICES=y
> NET_ETHERNET=y
> NET_VENDOR_3COM=y
> NET_VENDOR_SMC=y
> NET_TULIP=y
> NET_PCI=y
> 8139TOO_PIO=y
> NET_RADIO=y
> NET_WIRELESS=y
> NET_PCMCIA=y
> INPUT=y
> INPUT_KEYBOARD=y
> KEYBOARD_ATKBD=y
> SERIO=y
> SERIO_I8042=y
> SERIO_LIBPS2=y
> SOUND_GAMEPORT=y
> VT=y
> VT_CONSOLE=y
> HW_CONSOLE=y
> VGA_CONSOLE=y
> DUMMY_CONSOLE=y
> USB_ARCH_HAS_HCD=y
> USB_ARCH_HAS_OHCI=y
> USB_DEVICEFS=y
> USB_OHCI_LITTLE_ENDIAN=y
> USB_STORAGE_FREECOM=y
> USB_STORAGE_ISD200=y
> USB_STORAGE_DPCM=y
> USB_STORAGE_USBAT=y
> USB_STORAGE_SDDR09=y
> USB_STORAGE_SDDR55=y
> USB_STORAGE_JUMPSHOT=y
> USB_HIDINPUT=y
> USB_ALI_M5632=y
> USB_AN2720=y
> USB_BELKIN=y
> USB_GENESYS=y
> USB_NET1080=y
> USB_PL2301=y
> USB_KC2190=y
> USB_ARMLINUX=y
> USB_EPSON2888=y
> USB_ZAURUS=y
> USB_CDCETHER=y
> USB_AX8817X=y
> EXT2_FS=y
> JOLIET=y
> UDF_NLS=y
> NTFS_RW=y
> PROC_FS=y
> SYSFS=y
> TMPFS=y
> RAMFS=y
> NFS_V3=y
> LOCKD_V4=y
> MSDOS_PARTITION=y
> DEBUG_KERNEL=y
> MAGIC_SYSRQ=y
> CRYPTO=y
> GENERIC_HARDIRQS=y
> GENERIC_IRQ_PROBE=y
> X86_BIOS_REBOOT=y
> 
> -- 
>  Lab tests show that use of micro$oft causes cancer in lab animals
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Jeez... Is it just me or is it that most people today are too fucking retarded to use a computer?

Semper fi pengunius.
Webmaster of Segin's Open Source Den. 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
