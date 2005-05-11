Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVEKJFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVEKJFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 05:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVEKJEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 05:04:36 -0400
Received: from web40911.mail.yahoo.com ([66.218.78.208]:51069 "HELO
	web40911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261938AbVEKJCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 05:02:09 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Q/tb25g0paNwPAsJq8bh/VZNCN5eXNyN+iMUT2aKat7Osqd1HOfTPiGDmgGCg/+xUTdaSDSH7pKP/MTn7oMZjlYlBQQr/YNMzOU8Y79aZAfZA1yjKAUXW2mOAMRtGRcOkxDVn5qtTjdzgOv54sHNBnVzJmB6a4bQLrScd0zSNAA=  ;
Message-ID: <20050511090209.76029.qmail@web40911.mail.yahoo.com>
Date: Wed, 11 May 2005 02:02:08 -0700 (PDT)
From: jensen galan <jrgalan@yahoo.com>
Subject: did i trash my kernel?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I tried to create a custom kernel with an added system
call, so the goal was to have 2 kernels to choose from
at boot time.

In /usr/src/linux-2.4.28-gentoo-r5, I edited the
Makefile so that "EXTRAVERSION = -gentoo-r5-new", and
recompiled my custom kernel with the following
commands:

make mrproper
make menuconfig
make dep
make bzImage
make modules
make modules-install
make install

Now I have 2 kernels, and when I boot from the
original, I get the following error at boot:

Bringing eth0 up via DHCP... [!!]
ERROR: Problem starting needed services.
"netmount" was not started.

The original kernel I compiled with genkernel.  The
new kernel used the method described above.  Here is
my grub.conf:

default 0
timeout 30
splashimage=(hd0,0)/grub/splash.xpm.gz

title=Gentoo Linux 2.4.28-r5
root (hd0,0)
kernel /kernel-2.4.28-gentoo-r5 root=/dev/ram0
init=/linuxrc 
ramdisk=8192 real_root=/dev/hda3
initrd /initrd-2.4.28-gentoo-r5

title=Gentoo Linux 2.4.28-r5-new
root (hd0,0)
kernel /vmlinuz-2.4.28-gentoo-r5-new root=/dev/hda3

So, did I trash my original kernel?  Was the method I
used to compile a custom kernel incorrect?

Thank you for your help.

Jensen



	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail
