Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVCBO7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVCBO7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVCBO7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:59:51 -0500
Received: from web53306.mail.yahoo.com ([206.190.39.235]:41375 "HELO
	web53306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262327AbVCBO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:59:14 -0500
Message-ID: <20050302145907.17666.qmail@web53306.mail.yahoo.com>
Date: Wed, 2 Mar 2005 14:59:07 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: compilation problem of modules
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the code of the module that i written is as follows:
#define MODULE
#include <linux/module.h>
#include <linux/proc_fs.h>
#define MODULE_NAME "manti"
struct manti
{
      char mm[20];
 };
static struct proc_dir_entry *example_dir;
struct manti m1;
int init_module(void)
{
  example_dir=proc_mkdir(MODULE_NAME,NULL);
 if(example_dir==NULL)
  {
     printk("<1> error in creation of proc file\n");
    }
  else
   printk("<1>success in creation of proc dir\n");
  }
void cleanup_module(void)
{
   remove_proc_entry(MODULE_NAME,NULL);
  printk("<1>proc entry removed\n");
 }

here iam just making one directory in the proc file
named manti
i am trying to  compile it like
gcc -c proc.c 
where the kernel version is 2.4.20-8

but i am getting following errors 

In file included from proc.c:5:
/usr/include/linux/proc_fs.h:47: parse error before
"off_t"
/usr/include/linux/proc_fs.h:51: parse error before
"off_t"
/usr/include/linux/proc_fs.h:57: parse error before
"mode_t"
/usr/include/linux/proc_fs.h:59: parse error before
"uid"
/usr/include/linux/proc_fs.h:60: parse error before
"gid"
/usr/include/linux/proc_fs.h:70: parse error before
"count"
/usr/include/linux/proc_fs.h:72: parse error before
"rdev"
/usr/include/linux/proc_fs.h:176: parse error before
"mode_t"
/usr/include/linux/proc_fs.h: In function
`proc_net_create':
/usr/include/linux/proc_fs.h:177: `NULL' undeclared
(first use in this function)
/usr/include/linux/proc_fs.h:177: (Each undeclared
identifier is reported only once
/usr/include/linux/proc_fs.h:177: for each function it
appears in.)
/usr/include/linux/proc_fs.h: At top level:
/usr/include/linux/proc_fs.h:181: parse error before
"mode_t"
/usr/include/linux/proc_fs.h: In function
`create_proc_entry':
/usr/include/linux/proc_fs.h:181: `NULL' undeclared
(first use in this function)
/usr/include/linux/proc_fs.h: In function
`proc_symlink':
/usr/include/linux/proc_fs.h:185: `NULL' undeclared
(first use in this function)
/usr/include/linux/proc_fs.h: At top level:
/usr/include/linux/proc_fs.h:186: parse error before
"mode_t"
/usr/include/linux/proc_fs.h: In function
`proc_mknod':
/usr/include/linux/proc_fs.h:187: `NULL' undeclared
(first use in this function)
/usr/include/linux/proc_fs.h: In function
`proc_mkdir':
/usr/include/linux/proc_fs.h:189: `NULL' undeclared
(first use in this function)
/usr/include/linux/proc_fs.h: At top level:
/usr/include/linux/proc_fs.h:192: parse error before
"mode_t"
/usr/include/linux/proc_fs.h:193: parse error before
"off_t"
/usr/include/linux/proc_fs.h:193:
`create_proc_read_entry' declared as function
returning a function
/usr/include/linux/proc_fs.h:196: parse error before
"mode_t"
/usr/include/linux/proc_fs.h: In function
`create_proc_info_entry':
/usr/include/linux/proc_fs.h:197: `NULL' undeclared
(first use in this function)
/usr/include/linux/proc_fs.h: At top level:
/usr/include/linux/proc_fs.h:203: `NULL' used prior to
declaration
proc.c: In function `init_module':
proc.c:16: `NULL' has an incomplete type
proc.c:17: invalid operands to binary ==
proc.c: In function `cleanup_module':
proc.c:26: `NULL' has an incomplete type



how to solve it 
plz help me
is my compilation method is wrong or something else 

thanks 
sounak

________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
