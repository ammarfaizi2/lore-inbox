Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbRFXBEs>; Sat, 23 Jun 2001 21:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbRFXBEj>; Sat, 23 Jun 2001 21:04:39 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:44045 "HELO
	mail6.speakeasy.net") by vger.kernel.org with SMTP
	id <S262618AbRFXBEZ>; Sat, 23 Jun 2001 21:04:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: cd writer problems with 2.4.5ac17
Date: Sat, 23 Jun 2001 21:03:22 -0400
X-Mailer: KMail [version 1.2.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010624010433Z262618-17720+7036@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm thinking that this is a kernel scsi emu problem rather than a CDR problem 
due to the past scsi emulation mails i've seen about previous kernels.   I've 
been forced to move to 2.4.x because i want to use my promise ata66 ide 
controller and the 2.2 promise drivers dont work for it.  My CDR is detected 
as Vendor: CREATIVE  Model:  CD-RW RW8438E    Rev: FC03  by the ide-scsi 
module.   Now the problem is, cdrecord is very tempermental with it and it 
shouldn't be.  Often there are input output errors reading blank media before 
writing, these lead to drive lockups that can only be recovered by power 
cycling (rebooting).    The cdrecord i'm using is version 1.11a04 and i'm 
going to try an earlier release to see if it's a cdrecord issue in a bit but 
i wanted to get responses from anyone else who may be having these problems 
early if it isn't.  
Errors:     In dmesg this shows up. 

scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 
Write (10) 00 00 00 00 00 00 00 1f 00 
hde: irq timeout: status=0xd0 { Busy }
hde: ATAPI reset complete

I cant get the cdrecord actual error until i reboot, but then when i do it's 
random when the error does occur, just that it does after a few uses of the 
burner.  



on a side note.   the kernel really likes to hang up when writing to a cd.  
This never used to happen a few kernel releases ago.    it slows everything 
else down but when the cdr does write a cd, it does so without losing any 
fifo buffer.    
Any more info needed i'd like to give to figure this out, the thing is, 
everytime this happens i have to reboot to use the CDR again.  It wont even 
detect unless it's power cycled and just unplugging the power cord and 
putting it back in doesn't really help because it causes one of my other 
drives to flip out.  (did that last night.)  


