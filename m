Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVBGGPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVBGGPB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 01:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVBGGPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 01:15:00 -0500
Received: from web51110.mail.yahoo.com ([206.190.39.131]:3428 "HELO
	web51110.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261361AbVBGGOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 01:14:24 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=mT2G9OQokPAxPHTEcShq9DTYV39UgOY+W+lVwB6N8/eqO3ChGtoXaLktZpJMYui1rA/sBoF0UPeZg/NECRkObCt5Pv5nBCr6G/+AbLFkCgrRRmAbseZKIby8TOk8hnckYJsOjZwiGvLyuBrKeVj+KsOLoV+bFl26DCLdTz3iye0=  ;
Message-ID: <20050207061424.58043.qmail@web51110.mail.yahoo.com>
Date: Sun, 6 Feb 2005 22:14:23 -0800 (PST)
From: baswaraj kasture <kbaswaraj@yahoo.com>
Subject: Kernel 2.4.21 gives kernel panic at boot time
To: Christian Hildner <christian.hildner@hob.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <41FF45EA.5010908@hob.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have compiled the kerne 2.4.21. Compilation went
well. but i got follwing message at boot time.
=============================================
.
.
/lib/mptscsih.o : unresolved symbol
mpt_deregister_Rsmp_6fb5ab71
/lib/mptscsih.o : Unresolved symbol
mpt_event_register_Rsmp_34ace96b

ERROR : /bin/insmod exited abnormally
Mounting /proc filesystem
Creating block devices 
VFS : cannot open root device "LABEL=/ or 00:00
Please append corrrect "root=" boot option
Kernel panic : VFS : Unable to mount root fs on 00:00


===========================================


I have following lines in my elilo.conf ,
------------------------------
#original kernel
image=vmlinuz-2.4.21-9.EL
label=linux
initrd=initrd-2.4.21-9.EL.img
read-only
append="root=LABEL=/"

#icc-O2
image=iccvmlinux
label=icc_O2
initrd=iccinitrd-preBasicc.img
read-only
append="root=LABEL=/"
---------------------------
 First one works fine.

Any clues why  i am getting this error.

Is it related to SCSI Driver ?

Further "/sbin/mkinitrd -f -v  "  gave follwing
messge,
======================================
.
.
.
Looking for deps of module scsi_mod     
Looking for deps of module sd_mod       
Looking for deps of module unknown   
Looking for deps of module mptbase      
Looking for deps of module mptscsih     mptbase
Looking for deps of module mptbase      
Looking for deps of module ide-disk   
Looking for deps of module ext3 
Using modules: 
./kernel/drivers/message/fusion/mptbase.o
./kernel/drivers/message/fusion/mptscsih.o
Using loopback device /dev/loop0
/sbin/nash -> /tmp/initrd.EsIvQ9/bin/nash
/sbin/insmod.static -> /tmp/initrd.EsIvQ9/bin/insmod
`/lib/modules/2.4.21preBasicc/./kernel/drivers/message/fusion/mptbase.o'
-> `/tmp/initrd.EsIvQ9/lib/mptbase.o'
`/lib/modules/2.4.21preBasicc/./kernel/drivers/message/fusion/mptscsih.o'
-> `/tmp/initrd.EsIvQ9/lib/mptscsih.o'
Loading module mptbase
Loading module mptscsih

=======================================



Any clues will be great help ?


Thanx,
Baswaraj


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
