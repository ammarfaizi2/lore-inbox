Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbQKGUw5>; Tue, 7 Nov 2000 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKGUwr>; Tue, 7 Nov 2000 15:52:47 -0500
Received: from web6102.mail.yahoo.com ([128.11.22.96]:59398 "HELO
	web6102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129118AbQKGUwj>; Tue, 7 Nov 2000 15:52:39 -0500
Message-ID: <20001107205233.13661.qmail@web6102.mail.yahoo.com>
Date: Tue, 7 Nov 2000 12:52:33 -0800 (PST)
From: Anil kumar <anils_r@yahoo.com>
Subject: Installing kernel 2.4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
  I installed Red Hat 7.0, I am able to find the
  linux-2.2.16 in /usr/src

  These are the following steps I did to install
kernel 2.4:

  cd /usr/src
  #rm -r linux
   # rm -rf linux-2.2.16
   #tar -xvf  linux-2.4.0-test9.tar

  #cd /usr/src
#ls
 linux 
 redhat
 #mv  linux linux-2.4.0-test9
 #ln -s linux-2.4.0-test9 linux

  #ls
   linux->linux-2.4.0-test9
   linux-2.4.0-test9
   redhat
  
  #cd /usr/src/linux
  #make xconfig
  I just save & exit without changing the
configuration.
  #make dep
  #make clean
  #make bzImage
  #make modules
  #make modules_install

  I find that System.map is mapped to 2.4.0, ie.. new
  System-2.4.0-test9.map is created

  #cd /boot
  #ls
  #vmlinuz->vmlinuz-2.4.0-test9
  #cd /usr/src/linux/arch/i386/boot
  #cp bzImage /boot/vmlinuz
  
  #vi /etc/lilo.conf
  changed image from image = /boot/vmlinuz-2.2.16-22
to
  image = /boot/vmlinuz-2.4.0-test9

  #lilo
   linux
    dos

  when I boot linux

  The system hangs after messages:
  loading linux......
  uncompressing linux, booting linux kernel OK.

  The System hangs here.

  Please let me know where I am wrong

  with regards,
  Anil


__________________________________________________
Do You Yahoo!?
Thousands of Stores.  Millions of Products.  All in one Place.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
