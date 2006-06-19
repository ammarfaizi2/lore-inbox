Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWFSXGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWFSXGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWFSXGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:06:41 -0400
Received: from web33514.mail.mud.yahoo.com ([68.142.206.163]:35206 "HELO
	web33514.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964975AbWFSXGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:06:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SIkJ1H/TgrSdUMJthSTvIlUmPm5CFOjQuF0POehKZ6iuJCmLe8o3vb3r+3Fly6q47x8HqCcrBXiS1Itb5kFtO6NVfMqrQk7FXxuOR99KCdrat1SIDw03XmeGLtl5kZU+LEE5wil0wPSU6aWCrxLjEGKs5CkpWqLi5tGiBPk4lQs=  ;
Message-ID: <20060619230640.47177.qmail@web33514.mail.mud.yahoo.com>
Date: Mon, 19 Jun 2006 16:06:40 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: Re: sata_mv driver on 88sx6041 (kernel version 2.6.13)
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4496B47B.7070602@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. 
I moved further with the 2.6.20 sata_mv driver. Here
are the excerpts from dmesg with ata3 error messages
as follows:

sata_mv 0000:00:0d.0: version                         
   
PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)      
                                         
sata_mv 0000:00:0d.0: 32 slots 4 ports SCSI mode IRQ
via INTx                                              
              
ata1: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008022120
bmdma 0x0 irq 45                                      
                                
ata2: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008024120
bmdma 0x0 irq 45                                      
                                
ata3: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008026120
bmdma 0x0 irq 45                                      
                                
ata4: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008028120
bmdma 0x0 irq 45                                      
                                
ata1: no device found (phy stat 00000000)             
                           
scsi0 : sata_mv               
ata2: no device found (phy stat 00000000)             
                           
scsi1 : sata_mv               
ata3: dev 0 ATA-6, max UDMA/133, 156301488 sectors:
LBA48                                                 
       
ata3: qc timeout (cmd 0xef)                           
ata3: failed to set xfermode, disabled                
                     
ata3: dev 0 configured for UDMA/133                   
               
scsi2 : sata_mv               
ata4: no device found (phy stat 00000000)             
                           
scsi3 : sata_mv               
physmap flash device: 800000 at 1f400000 

  What is the significance of the
ata3: qc timeout (cmd 0xef)                           
ata3: failed to set xfermode, disabled 
 I am not able to get to the drive as attach is not
happening yet.
Thanks for the help.
Narendra            
--- Mark Lord <lkml@rtr.ca> wrote:

> Narendra Hadke wrote:
> > Hi,
> > I am using sata_mv driver as exists in kernel
> 2.6.13,
> > reached to a stage where after detecting the disk,
> > control gets struck. Any ideas? 
> 
> No surprises there.  The sata_mv driver is horribly
> buggy
> in all kernels prior to 2.6.16, and even there it
> still has
> some serious bugs.  The 2.6.17 kernel version is
> MUCH better.
> 
> Cheers
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
