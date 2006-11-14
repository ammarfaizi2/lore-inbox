Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965938AbWKOHmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965938AbWKOHmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965970AbWKOHmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:42:01 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:26641 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965938AbWKOHmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:42:00 -0500
Date: Tue, 14 Nov 2006 14:48:19 -0800
Message-Id: <200611142248.kAEMmJNP030370@fire-2.osdl.org>
From: bugme-daemon@bugzilla.kernel.org
To: rmk@arm.linux.org.uk
Subject: [Bug 7527] New: isicom segmentation fault
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Category: Drivers
X-Bugzilla-Component: Serial
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=7527

           Summary: isicom segmentation fault
    Kernel Version: 2.6.18.2
            Status: NEW
          Severity: normal
             Owner: rmk@arm.linux.org.uk
         Submitter: ef87@yahoo.com
                CC: jirislaby@gmail.com


Most recent kernel where this bug did *NOT* occur:
Distribution: Redhat EL 4
Hardware Environment: Intel x86
Software Environment:
Problem Description: Unable to access Modem

Steps to reproduce:

[root@dialin-0 ~]# setserial -g /dev/ttyM0
Segmentation fault
[root@dialin-0 ~]#
Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: Oops: 0000 [#1]

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: SMP

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: CPU:    0

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: EIP is at isicom_close+0x12/0x1ab [isicom]

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: eax: f5f14000   ebx: 00000000   ecx: f8922cf0   edx: f7f7fa40

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: esi: 00000000   edi: 00000000   ebp: f5f14000   esp: f5fc7e08

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: ds: 007b   es: 007b   ss: 0068

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: Process setserial (pid: 4258, ti=f5fc7000 task=f665ad30
task.ti=f5fc7000)

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: Stack: f8922cf0 f7f7fa40 f5f14000 00000000 00000000 00000000
c020c208 00000000

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel:        00000000 000200d0 00000002 00000000 f7f7fa40 c033f600
000000d0 c034c5e0

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel:        00000003 c034c5d0 00000000 00000001 f5fc7e7c c0117e96
00000000 00000000

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: Call Trace:

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: Code: 89 4d 06 89 c2 89 d8 59 5b 5b 5e 5f 5d e9 79 4e 9b c7 5f
5d 5b 5e 5f 5d c3 55 89 c5 57 56 53 51 51 89 54 24 04 8b 98 c0 01 00 00 <8b> 43
1c 85 db 89 04 24 0f 84 84 01 00 00 89 c6 83 c6 14 89 f0

Message from syslogd@dialin-0 at Tue Nov 14 14:41:38 2006 ...
dialin-0 kernel: EIP: [<f8922d02>] isicom_close+0x12/0x1ab [isicom] SS:ESP
0068:f5fc7e08

DMESG:

BUG: unable to handle kernel NULL pointer dereference at virtual address 0000001c
 printing eip:
f8922d02
*pde = 35f5c001
Oops: 0000 [#1]
SMP
Modules linked in: ipv6 autofs4 sunrpc ipt_REJECT xt_tcpudp xt_state
ip_conntrack iptable_filter ip_tables x_tables dm_mirror dm_mod button battery
asus_acpi ac uhci_hcd ehci_hcd isicom shpchp i2c_i801 i2c_core e1000 floppy ext3
jbd raid1 ata_piix libata sd_mod scsi_mod
CPU:    0
EIP:    0060:[<f8922d02>]    Not tainted VLI
EFLAGS: 00010286   (2.6.18.2 #1)
EIP is at isicom_close+0x12/0x1ab [isicom]
eax: f5f14000   ebx: 00000000   ecx: f8922cf0   edx: f7f7fa40
esi: 00000000   edi: 00000000   ebp: f5f14000   esp: f5fc7e08
ds: 007b   es: 007b   ss: 0068
Process setserial (pid: 4258, ti=f5fc7000 task=f665ad30 task.ti=f5fc7000)
Stack: f8922cf0 f7f7fa40 f5f14000 00000000 00000000 00000000 c020c208 00000000
       00000000 000200d0 00000002 00000000 f7f7fa40 c033f600 000000d0 c034c5e0
       00000003 c034c5d0 00000000 00000001 f5fc7e7c c0117e96 00000000 00000000
Call Trace:
 [<f8922cf0>] isicom_close+0x0/0x1ab [isicom]
 [<c020c208>] release_dev+0x19b/0x5d4
 [<c0117e96>] __wake_up+0x29/0x3c
 [<c020ac44>] tty_ldisc_enable+0x20/0x22
 [<c020bda0>] init_dev+0x370/0x483
 [<c020c7ef>] tty_open+0x1ae/0x2bb
 [<c01621fb>] chrdev_open+0x12f/0x14c
 [<c01620cc>] chrdev_open+0x0/0x14c
 [<c0159b98>] __dentry_open+0xc6/0x19e
 [<c0159d2a>] nameidata_to_filp+0x19/0x28
 [<c0159c9b>] do_filp_open+0x2b/0x31
 [<c01ca096>] strncpy_from_user+0x3c/0x5b
 [<c0159f03>] do_sys_open+0x3c/0xaf
 [<c0159f8c>] sys_open+0x16/0x18
 [<c0103235>] sysenter_past_esp+0x56/0x79
Code: 89 4d 06 89 c2 89 d8 59 5b 5b 5e 5f 5d e9 79 4e 9b c7 5f 5d 5b 5e 5f 5d c3
55 89 c5 57 56 53 51 51 89 54 24 04 8b 98 c0 01 00 00 <8b> 43 1c 85 db 89 04 24
0f 84 84 01 00 00 89 c6 83 c6 14 89 f0
EIP: [<f8922d02>] isicom_close+0x12/0x1ab [isicom] SS:ESP 0068:f5fc7e08

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
