Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVCaEQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVCaEQc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 23:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVCaEQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 23:16:32 -0500
Received: from [61.185.204.103] ([61.185.204.103]:28804 "EHLO
	dns.angelltech.com") by vger.kernel.org with ESMTP id S261945AbVCaEQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 23:16:23 -0500
Message-ID: <424B7A87.2070100@angelltech.com>
Date: Thu, 31 Mar 2005 12:20:23 +0800
From: rjy <rjy@angelltech.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: init process freezed after run_init_process
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My computer freezed after the kernel start. It started
with normal console messages and stopped with these messages:
------------------------------
... (just as the normal ones.)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
------------------------------
The kernel started successfully: it echos on keyboard pressing.
But the init process just REFUSE to work. GOD !

This is my grub config:
-----------------------------
root (hd0,0)
kernel /bzImage.via.386 root=/dev/ram0 rw ramdisk=49152
initrd /initrd.gz
-----------------------------

My CPU is VIA Samuel 2. Memory 128M. Chipset VIA VT82C686.
I configed my kernel with CyrixIII CPU family type,
and with RAM, INITRD and ext2/3 also on.

This kernel can work properly without initrd and ramdisk.
This kernel can work properly on intel CPU and chipset
even with initrd and ramdisk. :( Have I missed something?

I have KGDBed the starting process and run_init_process
returned OK: initrd decompressed properly and open_exec
returned non-zero.

Any instructions, references, or insight much appreciated.

Thanks
