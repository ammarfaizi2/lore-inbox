Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbRCHRJy>; Thu, 8 Mar 2001 12:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129344AbRCHRJp>; Thu, 8 Mar 2001 12:09:45 -0500
Received: from crane2.cf.ac.uk ([131.251.0.25]:40968 "EHLO crane2.cf.ac.uk")
	by vger.kernel.org with ESMTP id <S129339AbRCHRJZ>;
	Thu, 8 Mar 2001 12:09:25 -0500
From: "Mr. Jerome Corre" <CorreJ1@cf.ac.uk>
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Mar 2001 17:11:30 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: nfs mount result in invalid operand:000 (on 386 only)
Reply-to: CorreJ1@cf.ac.uk
X-mailer: Pegasus Mail for Win32 (v3.11)
Message-ID: <C29EA084F@MAINCF1M.CF.AC.UK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have recently been given an old 386 PC, I haven't got a hard disk 
for it, just a floppy and a network card, so I decided to create a boot 
disk for it, and then using nfs connect to one of my two pentium (which 
run RedHat 6.2) and work like that. I made a boot disk and with the 
linux 6.2 kernel and a root image, I tested on one of my pentium with the 
other pentium as an nfs server, it is working fine. However when i tryed 
it on the 386 things started to go wrong: 
1- when the kernel was booting i was getting: Checking if this processor 
honours the WP bit even in supervisor mode... No. Kernel panic: This 
Kernel doesn't support CPU's with broken WP. Recompile it for a 386! 
In swapper task - not syncing so i recompiled the kernel as explained in 
Kernel Howto and enable 386 support 
2- Now the kernel boot on the 386 but when i try to use mount to 
connect to the nfs server I get invalid operand: 000. Using strace i had a 
closer look to find out at what point mount was buging here is what i am 
getting: .....
mount("boggus:/home/export", "/mnt/temp/", "nfs", 0xc0ed0000, 
0x8057660) = -1 ENOSYS mount("boggus:/home/export", 
"/mnt/temp/", "nfs", 0xc0ed0000, 0x8057660invalid operand: 0000 
I have to say I don't know what to do now? did somebody solve that 
problem before? what else can i try to do to find out where the problem 
is comming from? thanks for any help regards 
Jerome 

