Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbVA2EvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbVA2EvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 23:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVA2EvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 23:51:06 -0500
Received: from web60605.mail.yahoo.com ([216.109.118.243]:32920 "HELO
	web60605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262853AbVA2Eu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 23:50:56 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=2vlAscb7tma35r5lXrWJ1Kor/Dwr7ycc9YJ4s8aEmL6tVuX4NJyDP2c9n4d+HPKegkHYJoD56ewr5ZRBIlJrarKk7he2O6sYLzwn7vIFt7AaORsEeQYLB+E+UZC2IJYLKb451cxsT2x4WcSEHMHcaeGOC31ZSQzcLv5QotWncYo=  ;
Message-ID: <20050129045056.80741.qmail@web60605.mail.yahoo.com>
Date: Fri, 28 Jan 2005 20:50:56 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Kernel oops on integrating a module with obj-y option
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

                 I am using Fedora core 1. I am doing
my project in the linux kernel 2.4.28. In my project,
I am intercepting system calls. I am doing all these
things from a module. Now, I installed this module
with the main kernel and I found it working nice when
I used 'modprobe' to load it.
                 Then I changed obj-m of my module to
obj-y and then I compiled my module object file with
the core kernel files like fs.o net.o kernel.o. So, my
target kernel binary code contains my module. Then I
booted my system. Now, the kernel oops sometimes and
sometimes it prompts for checking the disk and opens
the file system as a read only device.
                  To integrate my module, I created a
new subdirectory under the kernel source directory
named 'rsched' and I icreated my own make file for
that. The makefile contains the following lines
  obj-y := rsched.o ( previously obj-m := rsched.o)
  include $(TOPDIR)/Rules.make

   then I changed the following lines in the top level
make file.
  SUBDIRS := fs net kernel.... rsched
  CORE_FILES := kernel/kernel.o fs/fs.o ....
rsched/rsched.o

         How can I rectify this error so that I can
integrate my module with the main kernel image?

Thanks in advance and regards,
selva



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
