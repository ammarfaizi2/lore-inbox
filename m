Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUAVLlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 06:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUAVLlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 06:41:23 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:24511 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S266210AbUAVLlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 06:41:21 -0500
Message-ID: <400FB64D.2050806@iitbombay.org>
Date: Thu, 22 Jan 2004 17:08:53 +0530
From: Niraj Kumar <niraj17@iitbombay.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: 2.6.1 :  Kernel oops with rmmod 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
I am getting kernel oops after rmmod .  I was doing some changes in ufs 
filesystem
(basically , trying to add support for ufs2) and then loaded/unloaded 
the ufs module.
Loading was fine. But rmmod crashed with "Segmentation fault" .

[root@indl195ec kernel]# rmmod -v ufs
rmmod ufs, wait=no
Segmentation fault

[niraj@indl195ec niraj]$ cat /proc/version
Linux version 2.6.1 (root@indl195ec) (gcc version 3.2.3 20030502 (Red 
Hat Linux 3.2.3-20)) #2 Wed Jan 21 14:14:02 IST 2004


I am using the module-init-tools-3.0-pre7 .
The oops message is shown below (taken from dmesg):

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00210246
EIP is at 0x0
eax: 00000000   ebx: f89dcd80   ecx: 00000000   edx: f89dcd80
esi: 00000000   edi: bffff8f0   ebp: eefec000   esp: eefedf68
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 2037, threadinfo=eefec000 task=eefd46a0)
Stack: c0129df3 f89dcd80 bffff8f0 0000003b 00736675 00200086 f099e080 
ca1cb1c6
       00000033 4001a000 ca1cb1c6 00000033 f099e080 00083267 ca1cb867 
00000033
       eefd46a0 eefd4864 00000002 00000013 bffff8f0 bffff900 c010a7c1 
bffff8f0
Call Trace:
 [<c0129df3>] sys_delete_module+0x123/0x161
 [<c010a7c1>] sysenter_past_esp+0x52/0x71
 
Code:  Bad EIP value.



Niraj

