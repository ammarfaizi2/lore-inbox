Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVAKIXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVAKIXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 03:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVAKIXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 03:23:37 -0500
Received: from web60605.mail.yahoo.com ([216.109.118.243]:60756 "HELO
	web60605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262505AbVAKIXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 03:23:33 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=j3F4YCouIaJNFztEq7ln4WmSyTOTll5g3XjldBlyCZG4bjez+4hP65M+k5aqaziMrmdUYzjJdwuYbrpL+TU1hMakXcN0KRIagEPAB4gy+SoLerJtm3TRoK++lipWvzDBG0gMLX3P4ExOXT7++Dm+YYxx5pC0fJdXd8n6iKL5JT4=  ;
Message-ID: <20050111082332.58880.qmail@web60605.mail.yahoo.com>
Date: Tue, 11 Jan 2005 00:23:32 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: kfree error oops
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
     While I tried to free the memory I allocated
using kfree, I received the following error:
  I am working in kernel 2.4.28.
  I have also attached the code. Can anyone help me
regarding this? I have also checked for NULL pointer
even though it is not necessary.

Thanks,
selva
-----------------------
list_for_each(p,&rhash_table[i])
{
	//printk("\n Printing details for my..");

	my = list_entry(p, struct resource, res_list);
	if(my)
	{	
	printk("\n My is not null..");
	printk("\n%ld,",  my -> rid.fd);
	printk("%ld,",  my -> rid.inode);
	printk("%d,", my -> rid.ACCESS_TYPE);
        list_del(&my -> res_list);
        kfree(my);
}
--------------
<1>Unable to handle kernel paging request at virtual
address 170fc2ad
Jan 10 14:57:17 cbl032 kernel:  printing eip:
d076b210
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d076b210>]    Not tainted
EFLAGS: 00010206
eax: 170fc2a5   ebx: ca502000   ecx: 00000020   edx:
ffffffff
esi: 00000400   edi: 00000000   ebp: bffffb98   esp:
ca503fa4
Jan 10 14:57:17 cbl032 random: Saving random seed: 
failed
ds: 0018   es: 0018   ss: 0018
Process initlog (pid: 6677, stackpage=ca503000)
Stack: 00000020 ffffffff 00000001 c01166c0 bffffb98
c0108ccc ca502000 c0108bdb 
       00000020 4b26f940 00000020 00000400 00000000
bffffb98 00000006 0000002b 
       0000002b 00000006 4b208ba1 00000023 00000246
bffffb4c 0000002b 
Call Trace:    [<c01166c0>] [<c0108ccc>] [<c0108bdb>]

Code: 8b 40 08 8b 40 08 8b 50 28 89 54 24 04 c7 44 24
08 01 00 00 
 



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
