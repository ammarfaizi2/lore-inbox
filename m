Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132744AbRDINIW>; Mon, 9 Apr 2001 09:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132743AbRDINIO>; Mon, 9 Apr 2001 09:08:14 -0400
Received: from lnnet02.lip.pt ([193.136.91.231]:41487 "EHLO lnnet02.lip.pt")
	by vger.kernel.org with ESMTP id <S132741AbRDINIA>;
	Mon, 9 Apr 2001 09:08:00 -0400
Message-ID: <3AD1B429.E7407D8@lip.pt>
Date: Mon, 09 Apr 2001 14:07:53 +0100
From: Joao Paulo Martins <martinsj@lip.pt>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: pt, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i2o & Promise SuperTrak100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I purchase a Promise SuperTrak100 RAID controler and
installed on a PIII dual with latest kernel 2.4.3. It didn't
work, so I searched the linux-kernel achives and found an exact
discription of my problem by David Priban on Feb. 27 2001
(http://www.uwsg.iu.edu/hypermail/linux/kernel/0102.3/0037.html).
Andrew Morton and Alan Cox gave an hand. I follow hte hists
and advance a bit, and as David, now I get a bunch of I/O errors
on mounted array. After this there was a sugestion of timing problems,
but the issue ended with no solution.

	Could any one help me, please!
	Let me thank you in advance for any help.

	I have no problem starting the i2o_block modules, I can
run a create a partition, but when I try to make a file system
I get a lot of I/O erros:

	> modprobe i2o_block
	> fdisk /dev/i2o/hd/disc0/disc
	> mkreiserfs /dev/i2o/hd/disc0/part1

syslog:

Linux I2O PCI support (c) 1999 Red Hat Software. 
I2O Core - (C) Copyright 1999 Red Hat Software 
i2o: Checking for PCI I2O controllers... 
i2o: I2O controller on bus 1 at 25. 
i2o: PCI I2O controller at 0xFE000000 size=4194304 
i2o/iop0: Installed at IRQ22 
i2o: 1 I2O controller found and installed. 
I2O: Event thread created as pid 1029 
Activating I2O controllers... 
This may take a few minutes if there are many devices 
i2o/iop0: Reset rejected, trying to clear 
i2o/iop0: LCT has 10 entries. 
i2o/iop0: Configuration dialog desired. 
Target ID 0. 
    Device: IxWorks 
      Rev: 0201     
  Class: Executive             
Subclass: 0x0001 
      Flags: PM 
Target ID 8. 
     Vendor: PROMISE TECH.    
     Device: I2O RAID ISM     
        Rev: V1.0.0   
    Class: Device Driver Module  
  Subclass: 0x0021 
     Flags: PM 
Target ID 9. 
     Vendor: PROMISE TECH.    
     Device: I2O IDE HDM      
        Rev: 0.02     
    Class: Device Driver Module  
  Subclass: 0x0020 
     Flags: PM 
Target ID 10. 
     Vendor: VENDOR-UNKNOWN   
     Device: IBM-DTLA-307060  
        Rev: TX8OA50C 
    Class: Block Device          
  Subclass: 0x0000 
     Flags: CPM 
Target ID 12. 
     Vendor: VENDOR-UNKNOWN   
     Device: IBM-DTLA-307060  
        Rev: TX8OA50C 
    Class: Block Device          
  Subclass: 0x0000 
     Flags: CPM 
Target ID 13. 
     Vendor: VENDOR-UNKNOWN   
     Device: IBM-DTLA-307060  
        Rev: TX8OA50C 
    Class: Block Device          
  Subclass: 0x0000 
     Flags: CPM 
Target ID 14. 
     Vendor: VENDOR-UNKNOWN   
     Device: IBM-DTLA-307060  
        Rev: TX8OA50C 
    Class: Block Device          
  Subclass: 0x0000 
     Flags: CPM 
Target ID 15. 
     Vendor: VENDOR-UNKNOWN   
     Device: IBM-DTLA-307060  
        Rev: TX8OA50C 
    Class: Block Device          
  Subclass: 0x0000 
     Flags: CPM 
Target ID 16. 
     Vendor: VENDOR-UNKNOWN   
     Device: IBM-DTLA-307060  
        Rev: TX8OA50C 
    Class: Block Device          
  Subclass: 0x0000 
     Flags: CPM 
Target ID 17. 
     Vendor: PROMISE TECH.    
     Device: I2O RAID DEVICE  
        Rev: V1.0.0   
    Class: Block Device          
  Subclass: 0x0000 
     Flags: PM 
i2o/iop0: No handler for event (0x02000000) 
I2O Block Storage OSM v0.9 
   (c) Copyright 1999, 2000 Red Hat Software. 
i2o_block: registered device at major 80 
i2ob: Installing tid 17 device at unit 0 
Max Segments set to 12 
Byte limit is 6144. 
i2o/hda: Type 1- 293220Mb, 512 byte sectors. 
i2o/hda: Maximum sectors/read set to 255. 
 i2o/hda: p1 
devfs: devfs_register(disc): NULL ops, got d0c18ef0 from major table 
 
/dev/i2o/hda error: Device is not ready 
end_request: I/O error, dev 50:00 (i2o block), sector 22600 
 
/dev/i2o/hda error: Device is not ready 
end_request: I/O error, dev 50:00 (i2o block), sector 22600 

(errors repeat many times)



-- 
------------------------------------------------------------------
Joao Martins                            martinsj@lip.pt
Av. Elias Garcia, 14-1                  Tel: +351 21 797 3880
1000-149 Lisboa Portugal                Fax: +351 21 793 4631
