Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWFHWsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWFHWsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 18:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWFHWsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 18:48:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:26103 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965034AbWFHWsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 18:48:21 -0400
Message-ID: <4488A927.2070809@i12.com>
Date: Fri, 09 Jun 2006 00:48:07 +0200
From: Philipp Baumann <pumuckl@i12.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc6-mm1] Oops during sata_promise init
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:80ab310fced15248f8e2da3e2d36cb52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

testing the latest mm kernel, i still get an Oops as follows:


BUG: unable to handle kernel NULL pointer dereference at virtual address 
00000008
printing eip:
c0256773
*pde  =  00000000
Oops: 0002 xxxx
4K_STACKS PREEMPT
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c0256773>]    Not tainted VLI
EFLAGS:    00010202 (2.6.17-rc6-mm1 #1)
EIP is at pdc_sata_scr_write+0x10/0x14
eax: 00000008  ebx: dfeb429c  ecx: 00000300  edx: 0000002
esi: dfeb429c  edi: 00000300  ebp: 00000002  esp: dffc3e44
ds: 007b  es: 007b  ss: 0068
Process idle (pid: 1, threadinfo=dffc3000 task=dffc2ab0)
Stack:  c02cb980 c024c84b dfeb429c dfeb0c78 fffb82ca dfeb429c c024e4b5 
c0244541
    c02e60a6 c3000000 c01ea753 c0256281 dfeb429c dfeb0c78 00000002 c024e5bc
    dfeb0834 c0250cee dfeac408 e1493800 00000053 c02e6ef3 e0802300 c0802338
Call Trace:
[<c024c84b>] sata_scr_write_flush+0x24/0x37
[<c024e4b5>] __sata_phy_reset+0x2e/0x12d
[<c0244541>] scsi_add_host+0xc0/0x192
[<c01ea753>] __delay+0x6/0x7
[<c0256281>] pdc_reset_port+0x1f/0x34
[<c024e5bc>] sata_phy_reset+0x8/0x18
[<c0250cee>] ata_device_add+0x580/0x6b1
[<c0256c41>] pdc_ata_init_one+0x2a9/0x3c8
[<c01f5732>] pci_device_probe+0x40/0x5b
[<c023f70b>] driver_probe_device+0x3b/0xaa
[<c023f830>] __driver_attach+0x5a/0x5c
[<c023f1c4>] bus_for_each_dev+0x3a/0x58
[<c023f67a>] driver_attach+0x16/0x1a
[<c023f7d6>] --driver_attach+0x0/0x5c
[<c023ee9c>] bus_add_driver+0x6f/0x11f
[<c01f5889>] __pci_register_driver+0x34/0x4f
[<c010028c>] init+0x6c/0x225
[<c02bd34e>] __kprobes_text_start+0x6/0x14
[<c0100220>] init+0x0/0x225
[<c0100220>] init+0x0/0x225
[<c0101005>] kernel_thread_helper+0x5/0xb
Code: 02 77 0a 8d 04 12 01 c0 03 41 60 8b 00 c3 8b 80 78 1f 00 00 8b 40 
08 8b 40 40 c3 53 89 c3 83 fa 02 77 0a 8d
04 12 01 c0 03 43 60 <89> 08 5b c3 55 57 56 53 83 ec 10 89 c6 9c 5d fa 
b8 00 f0 ff ff
EIP: [<c0256773>] pdc_sata_scr_write+0x10/0x14 SS:ESP 0068:dffc3e44
<0>Kernel panic - not syncing: Attempted to kill init!

any advice?

kind regards

prx
