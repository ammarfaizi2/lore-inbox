Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267470AbUIKG5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267470AbUIKG5g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 02:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUIKG5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 02:57:36 -0400
Received: from web51607.mail.yahoo.com ([206.190.38.212]:28072 "HELO
	web51607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267470AbUIKG5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 02:57:20 -0400
Message-ID: <20040911065719.9286.qmail@web51607.mail.yahoo.com>
Date: Fri, 10 Sep 2004 23:57:19 -0700 (PDT)
From: ngo giang <ngohoanggiang1981dh@yahoo.com>
Subject: Build kernel : Error when reboot
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello , 

I’m using Linux RedHat 8 , kernel-2.4.18
I’m trying to build kernel-2.4.26
I did following :
……….
make rmproper 
make xconfig 
make dep 
make clean 
make bzImage 
 make modules  
make modules_install 
rm –rf  /boot/System.map
rm –rf /boot/vmlinuz
cp arch/i386/boot/bzImage /boot/bzImage-xxx
cp System.map /boot/System.map-xxx
ln -s /boot/vmlinuz-x.x.x /boot/vmlinuz
ln -s /boot/System.map-x.x.x /boot/System.map

I configured grub.conf  as follow :

//old configuration
title Linux Red Hat (2.4.18-14) 
root(hd0,0)
kernel /vmLinuz-2.4.18-14 ro root=LABEL=/
initrd /initrd-2.4.18-14.img

//my configuration
title New Kernel (2.4.26)
root(hd0,0)
kernel /vmLinuz-2.4.26 ro root=LABEL=/

when reboot 
I received  the error as follow :

“VFS : cannot open root device “ label = / “ or 00:00
Please append a correct “ root = “ boot option 
Kernel panic : VFS : Unable to mount root fs on 00:00
“

 I did : root=/dev/sda1 ( or root=/dev/sda2 ) 
but I  received  error :
kmod : failed to exec /sbin/modprobe –s –k 
block-major-8 errno = 2
VFS : ....( similar to the first case )

Can anyone help me .

Thanks for yours help !


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
