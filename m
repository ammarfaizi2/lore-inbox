Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUIKEWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUIKEWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 00:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267406AbUIKEWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 00:22:16 -0400
Received: from web51606.mail.yahoo.com ([206.190.38.211]:16493 "HELO
	web51606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267405AbUIKEWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 00:22:13 -0400
Message-ID: <20040911042213.8980.qmail@web51606.mail.yahoo.com>
Date: Fri, 10 Sep 2004 21:22:13 -0700 (PDT)
From: ngo giang <ngohoanggiang1981dh@yahoo.com>
Subject: Error with initrd when build kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I’m using Linux RedHat 8 , kernel-2.4.18
I’m trying to build kernel-2.4.26
I did following :
……….
make xconfig , make dep , make clean , make bzImage
make modules , make modules_install 
mkinitrd --omit-scsi-modules /boot/initrd-xxx.img xxx
cp arch/i386/boot/bzImage /boot/bzImage-xxx
cp System.map /boot/System.map-xxx
ln -s /boot/System.map-xxx /boot/System.map

Every thing fine

But when I configured grub.conf  as follow :

title ( ….) 
root(hd0,0)
kernel /bzImage-2.4.26 ro root=LABEL=/
(  I don’t know where my root is on )
initrd /initrd-2.4.26.img

when reboot 
I received  the error as follow :

“ VFS : cannot open root device “ label = / “ or 00:00
Please append a correct “ root = “ boot option 
Kernel panic : VFS : Unable to mount root fs on 00:00
“

Can anyone tell me how I can configure the grub.conf
or 
how the configuration is ( at stage : make xconfig ) 
to avoid creating initrd   

Could anyone help me .

Thanks for yours help !





	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
