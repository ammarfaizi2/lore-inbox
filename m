Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUHaQVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUHaQVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUHaQVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:21:54 -0400
Received: from web50610.mail.yahoo.com ([206.190.38.249]:29374 "HELO
	web50610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262138AbUHaQUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:20:02 -0400
Message-ID: <20040831161956.931.qmail@web50610.mail.yahoo.com>
Date: Tue, 31 Aug 2004 09:19:56 -0700 (PDT)
From: Jeba Anandhan A <jeba_career@yahoo.com>
Subject: Kernel OOPS[filesystem programming]
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have written kernel program to access the data
structure of particular inode.

#include<linux/kernel.h>
#include<linux/module.h>
#include<linux/fs.h>
                                                      
                                                      
              
                                                      
                                                      
              
static struct inode *my_inode;
static unsigned long inode_no;
int init_module(void){
printk("inode module inserted\n");
inode_no=1304012;
printk("inode no=%d",inode_no);
my_inode->i_ino=inode_no; // it creates segmentation
//fault why so..
return 0;
}
                                                      
                                                      
              
void cleanup_module(void){
}
                                                      
                                                      
              
when i insert the module ,kernel got OOPS.
~
<1>Unable to handle kernel NULL pointer dereference at
virtual address 00000028
 printing eip:
d09c80a1
*pde = 0841b067
*pte = 00000000
Oops: 0002
inodetraversal1 inodetraversal i810_audio ac97_codec
soundcore parport_pc lp parport autofs 3c59x floppy sg
microcode ide-scsi scsi_mod ide-cd cdrom keybdev h
CPU:    0
EIP:    0060:[<d09c80a1>]    Tainted: P
EFLAGS: 00210282
 
EIP is at init_module [inodetraversal1] 0x41
(2.4.22-1.2115.nptl)
eax: 00000000   ebx: c0349124   ecx: 00000001   edx:
0013e5cc
esi: 00000000   edi: 00000000   ebp: c4123f10   esp:
c4123f08
ds: 0068   es: 0068   ss: 0068
Process insmod (pid: 7866, stackpage=c4123000)
Stack: c0349124 00000000 d09c8000 c011ed74 c03badb4
00000001 d09c8000 00000000
       08ea51c3 d09c8060 00000003 000000d3 00000060
0000000f c89855c0 ccd26000
       cbbb4000 d09ca000 00000060 d09ad000 d09c8060
0000037c 00000000 00000000
Call Trace:   [<c011ed74>] sys_init_module [kernel]
0x584 (0xc4123f14)
[<d09c8060>] init_module [inodetraversal1] 0x0
(0xc4123f2c)
[<d09c8060>] init_module [inodetraversal1] 0x0
(0xc4123f58)
[<c0109b9f>] system_call [kernel] 0x33 (0xc4123fc0)
 
 
Code: 89 50 28 b8 00 00 00 00 c9 c3 55 89 e5 c9 c3 69
6e 6f 64 65
  
whatz problem with my program.how to rectify.?
jeba

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
