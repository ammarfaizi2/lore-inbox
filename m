Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVASHZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVASHZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVASHZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:25:48 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:38788 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261612AbVASHZi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:25:38 -0500
X-OB-Received: from unknown (205.158.62.133)
  by wfilter.us4.outblaze.com; 19 Jan 2005 07:25:36 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
From: "prashanth M D" <prashanthmd@indiainfo.com>
To: plars@linuxtestproject.org
Date: Wed, 19 Jan 2005 12:55:36 +0530
Subject: Help needed: GCOV - not getting HOW TO!!!
X-Originating-Ip: 61.11.66.87
X-Originating-Server: ws5-3.us4.outblaze.com
Message-Id: <20050119072536.AE66F23CF7@ws5-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I got your id from google..
I have just started working on kernel code coverage project...

I have patched my kernel and i have configured the gcov kernel module support.
I compilied my module and i run insmod and i got my module executed.
But i am not getting the .da file in /proc/gcov/kernel for my module...
my sample module looks somthing like this,

#include<linux/module.h>
#include<linux/kernel.h>
#include<linux/config.h>

MODULE_LICENSE("GPL");

int init_module (void){


         printk("HELLO WORLD");
         return 0;
}

void cleanup_module (void){

         printk ("In cleanup module NTPL \n");

}

the commands are as follows...

1.  gcc  -D__KERNEL__ -DMODULE -DLINUX -O2 -Wall -Wstrict-prototypes 
-fno-strict-aliasing -fno-strict-aliasing
     -c -o test.o -fprofile-arcs -ftest-coverage  test.c

2.  insmod gcov-proc.o

3.  insmod test.o

         This must generate a test.da file in /proc/gcov/kernel/  
according to a manual i have but i am not
         getting this file generated...

I am using :
               kernel version linux-2.4.18
               gcc compiler version 3.0.4


Please tell me where i am going wrong.

Please help me out...

Thanking you,

Prashanth M D
Phone : 9886340890

-- 
______________________________________________
IndiaInfo Mail - the free e-mail service with a difference! www.indiainfo.com 
Check out our value-added Premium features, such as an extra 20MB for mail storage, POP3, e-mail forwarding, and ads-free mailboxes!

Powered by Outblaze
