Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSJHOjH>; Tue, 8 Oct 2002 10:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbSJHOjH>; Tue, 8 Oct 2002 10:39:07 -0400
Received: from ndmnet.com ([24.237.5.185]:36613 "EHLO ndmnet.com")
	by vger.kernel.org with ESMTP id <S261433AbSJHOjF>;
	Tue, 8 Oct 2002 10:39:05 -0400
Message-ID: <3DA2EF5D.4080504@ndmnet.com>
Date: Tue, 08 Oct 2002 06:44:45 -0800
From: Kent Overstreet <kent@ndmnet.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops when rebooting
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just compiled 2.5.41, everything seems to work fine except it oopses 
reliably when rebooting. It's a tyan tiger mpx with a single cpu. Kernel 
was configured for smp, preemptible, and acpi. I can send my .config if 
it'll help

Oops is in driverfs_remove_file + 0x46/0x60
Process reboot
Call trace:
device_remove_file
driverfs_remove_partitions
del_gendisk
idedisk_cleanup
ide_notify_reboot
notifier_call_chain
sys_reboot
__get_page_state
sync_inodes_sb
backround_writeout
sync_inodes
syscall_call

I can get the rest of the oops if needed, didn't particularly want to 
copy all of it down

Please CC, as i'm not on the list.

Kent Overstreet

