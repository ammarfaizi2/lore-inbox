Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVBPOge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVBPOge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVBPOge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:36:34 -0500
Received: from web53101.mail.yahoo.com ([206.190.39.204]:9325 "HELO
	web53101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262023AbVBPOg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:36:26 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=jLoMZkTe9zl3LMhPtoh7K3y12QgSata1Ng7Fg8+/2HZ65ROa+6FoDG7bN+MOkU6B8L26SbMvZRjFU8M8npJUP4J5CEWNsvPcmzIx3CVmBegMFHhxur8cnxctJ+G2CvLOlsF8ETWmo2TO9tEctRDN73gSpTDPkyOD+9lerk8njNU=  ;
Message-ID: <20050216143625.8925.qmail@web53101.mail.yahoo.com>
Date: Wed, 16 Feb 2005 06:36:25 -0800 (PST)
From: Kent Hunt <kenthunt@yahoo.com>
Subject: 2.6.11-rc4 + ide + S3 suspend = lockup?
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

S3 has been working most of the times but sometimes I
experience lockups. I'm wondering if the error
messages for hdc may be a possible cause.

dmesg                                                 
                                                 
hdc: UJDA755 DVD/CDRW, ATAPI CD/DVD-ROM drive         
                                                 
                                                      
                                                 
lspci                                                 
                                                 
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM
(ICH4) Ultra ATA Storage Controller (rev 03)          

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge
(rev 83)                                          
0000:00:00.0 Host bridge: Intel Corp. 82855PM
Processor to I/O Controller (rev 03)                  
   
                                                      
                                                 
syslog after resuming from S3                         
                                                 
                                                      
                                                 
hdc: drive_cmd: status=0x51 {DriveReady SeekComplete
Error }                                            
drive_cmd: error=0x04 {AbortedCommand }               
                                                 
ide: failed opcode was: 0xef                          
                                                 
drive_cmd: status=0x51 {DriveReady SeekComplete Error
}                                                 
hdc: drive_cmd: error=0x04 {AbortedCommand }          
                                                 
ide: failed opcode was: 0xe3                          
                                                 
                                                      
                                                 
CONFIG_IDE=y                                          
                                                 
CONFIG_BLK_DEV_IDE=y                                  
                                                 
CONFIG_BLK_DEV_IDEDISK=y                              
                                                 
CONFIG_IDEDISK_MULTI_MODE=y                           
                                                 
CONFIG_BLK_DEV_IDECS=m                                
                                                 
CONFIG_BLK_DEV_IDECD=y                                
                                                 
CONFIG_BLK_DEV_IDETAPE=m                              
                                                 
CONFIG_BLK_DEV_IDEFLOPPY=m                            
                                                 
CONFIG_BLK_DEV_IDESCSI=m                              
                                                 
CONFIG_IDE_GENERIC=y                                  
                                                 
CONFIG_BLK_DEV_IDEPCI=y                               
                                                 
CONFIG_IDEPCI_SHARE_IRQ=y                             
                                                 
CONFIG_BLK_DEV_GENERIC=y                              
                                                 
CONFIG_BLK_DEV_IDEDMA_PCI=y                           
                                                 
CONFIG_IDEDMA_PCI_AUTO=y                              
                                                 
CONFIG_BLK_DEV_PIIX=y                                 
                                                 
CONFIG_BLK_DEV_IDEDMA=y                               
                                                 
CONFIG_IDEDMA_AUTO=y                                  
                                                 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
