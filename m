Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272164AbRH3KgW>; Thu, 30 Aug 2001 06:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272167AbRH3KgN>; Thu, 30 Aug 2001 06:36:13 -0400
Received: from web14701.mail.yahoo.com ([216.136.224.118]:39180 "HELO
	web14701.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272165AbRH3Kfw>; Thu, 30 Aug 2001 06:35:52 -0400
Message-ID: <20010830103609.96135.qmail@web14701.mail.yahoo.com>
Date: Thu, 30 Aug 2001 11:36:09 +0100 (BST)
From: "=?iso-8859-1?q?Mark=20A.=20Tagliaferro?=" <be_lak@yahoo.co.uk>
Subject: Problems with compiling kernel.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using SuSE 7.1 and I had to compile the kernel to include SCSI support. 
That part is all well and good.  The problems started when I tried to set up
masquerading.  Modprobe is returning the following error:

modprobe: Can't open dependencies file /lib/modules/2.4.2/modules.dep (No such
file or directory)

I looked in /lib/modules/ and there the directory is called 2.4.2-4GB and not
2.4.2 

I tried to fool it by creating a virtual link to the directory with the name
2.4.2 but then the modprobe returns a large number of kernal mismatch errors 
that the particular modules (iptable_nat) I am trying to run were written for
kernel version 2.4.2-4GB and not 2.4.2

It looks like modprobe is looking for kernel version 2.4.2 but the modules are
for kernel 2.4.2-4GB.

Incidentally I have another machine with the standard kernel that YaST installs
on which modprobe works well and the directory in /lib/modules/ is calle
2.4.2-4GB.

Any idea as to what I'm doing wrong?
Did I have to recompile the kernel to load the aic7xxx or could I have added a
command in some initialisation file to load it as a module (insmod)?

Regards
Mark


____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
