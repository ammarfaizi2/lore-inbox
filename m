Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUF3XSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUF3XSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 19:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUF3XSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 19:18:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10388 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263154AbUF3XSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 19:18:06 -0400
Message-ID: <40E34A1F.1040406@pobox.com>
Date: Wed, 30 Jun 2004 19:17:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Danny ter Haar <dth@ncc1701.cistron.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: problems with SATA: 2.6.7 working, -bk12/13/-mm4 not
References: <cbvgor$lgp$1@news.cistron.nl>
In-Reply-To: <cbvgor$lgp$1@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar wrote:
> 1U 19" server supermicro with ICH5 & P4.
> 
> runs 2.6.7 vanilla without problems.
> 
> tried -bk12/-bk13/-mm4 which won't work
> Machine is on serial console and captures output looks  like
> this:
> 
> Using local APIC timer interrupts.                                              
> calibrating APIC timer ...                                                      
> ..... CPU clock speed is 2595.0172 MHz.                                         
> ..... host bus clock speed is 199.0628 MHz.                                     
> checking TSC synchronization across 2 CPUs: passed.                             
> Brought up 2 CPUs                                                               
> NET: Registered protocol family 16                                              
> PCI: PCI BIOS revision 2.10 entry at 0xfb1b0, last bus=2                        
> PCI: Using configuration type 1                                                 
> mtrr: v2.0 (20020519)                                                           
> ACPI: Subsystem revision 20040326                                               
> ACPI: Interpreter enabled                                                       
> ACPI: Using IOAPIC for interrupt routing                                        
> ACPI: PCI Root Bridge [PCI0] (00:00)                                            
> PCI: Probing PCI hardware (bus 00)                                              
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2                             
> PCI: Transparent bridge - 0000:00:1e.0                                          
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 9 10 11 12 14 15)                
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)                
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)                
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)                
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.   
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.   
> ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 *10 11 12 14 15)     
> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 11 *12 14 15)                
> SCSI subsystem initialized                                                      
> PCI: Using ACPI for IRQ routing                                                 
> ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16            
> ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19            
> ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18            
> ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16            
> ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23            
> ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18            
> ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17            
> ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 16 (level, low) -> IRQ 16            
> ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 22   
> ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 23            
> testing the IO APIC.......................                                      
> .................................... done.                                      
> Starting balanced_irq                                                           
> Total HugeTLB memory allocated, 0                                               
> VFS: Disk quotas dquot_6.5.1                                                    
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)                      
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)                          
> devfs: boot_options: 0x0                                                        
> SGI XFS with ACLs, security attributes, no debug enabled                        
> SGI XFS Quota Management subsystem                                              
> SELinux:  Registering netfilter hooks              
> Initializing Cryptographic API                                                  
> Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing disabled       
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A                                        
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A                                        
> loop: loaded (max 8 devices)                                                    
> Intel(R) PRO/1000 Network Driver - version 5.2.52-k4                            
> Copyright (c) 1999-2004 Intel Corporation.                                      
> ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 22            
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection                  
> ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 23            
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection                  
> netconsole: not configured, aborting                           
> ata_piix: combined mode detected                                                
> ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18            
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14                 
> ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48                         
> ata1: dev 1 ATA, max UDMA/100, 488397168 sectors: lba48                         
> ata1: dev 0 configured for UDMA/100                                             
> ata1: dev 1 configured for UDMA/100                                             
> scsi0 : ata_piix                                                                
> Using anticipatory io scheduler                                                 
>   Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5                          
>   Type:   Direct-Access                      ANSI SCSI revision: 05             
>   Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O              
>   Type:   Direct-Access                      ANSI SCSI revision: 05             
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15                  
> ata2: dev 0 ATAPI, max UDMA/33                                                  
> ata2: dev 0 configured for UDMA/33                                              
> scsi1 : ata_piix                                                                
> SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)                    
> SCSI device sda: drive cache: write back                                        
>  /dev/scsi/host0/bus0/target0/lun0:<3>ata1: command 0x25 timeout, stat 0xd0 hos4
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 00 00 00 00 00 08  
> Current sda: sense key Medium Error                                             
> Additional sense: Unrecovered read error - auto reallocate failed               
> end_request: I/O error, dev sda, sector 0                                       
> ATA: abnormal status 0xD0 on port 0x1F7                                         
> ATA: abnormal status 0xD0 on port 0x1F7                                         
> ATA: abnormal status 0xD0 on port 0x1F7                      

Can you try:

* disabling combined mode in BIOS
* finding which -bk snapshot breaks your system
* acpi=off (disabling ACPI)
* noapic
* copying the following files verbatim into your 2.6.7-{bk12,bk13,mm4} tree:
	drivers/scsi/libata*.[ch]
	drivers/scsi/ata_*.c
	drivers/scsi/sata_*.[ch]
	include/linux/libata.h
	include/linux/ata.h

