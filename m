Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUKGSbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUKGSbC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 13:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUKGSbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 13:31:02 -0500
Received: from mailgate2.uni-paderborn.de ([131.234.22.35]:33977 "EHLO
	mailgate2.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261668AbUKGSas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 13:30:48 -0500
Message-ID: <418E69D4.3000709@uni-paderborn.de>
Date: Sun, 07 Nov 2004 19:30:44 +0100
From: =?ISO-8859-15?Q?Bj=F6rn_Schmidt?= <bj-schmidt@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in CIFS / 2.6.9 / i386
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.025,
	required 4, AUTH_EIM_USER -5.00, RCVD_IN_BL_SPAMCOP_NET 2.25,
	RCVD_IN_DYNABLOCK 1.00, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-MailScanner-From: bj-schmidt@uni-paderborn.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel paging request at virtual address 01380002
  printing eip:
c011b063
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: iptable_nat ipt_REJECT ipt_pkttype ipt_ULOG ipt_state 
ip_conntrack iptable_filter ip_tables vmnet parport_pc parport vmmon usbhid 
uhci_hcd usbcore
CPU:    0
EIP:    0060:[<c011b063>]    Tainted: P   VLI
EFLAGS: 00010086   (2.6.9-ts3000-514)
EIP is at __wake_up_common+0x13/0x70
eax: 01380002   ebx: cf34e000   ecx: 00000001   edx: 00000003
esi: 00000000   edi: dfc28cb8   ebp: cf34ecbc   esp: cf34eca0
ds: 007b   es: 007b   ss: 0068
Process mount.cifs (pid: 26249, threadinfo=cf34e000 task=c7ec6aa0)
Stack: ffffffdf c011e99f 00000001 00000003 cf34e000 00000000 00000282 cf34ecd8
        c011b0ef 00000000 00000000 00000001 00000000 cf34ed3c dfc28a60 c01bf8cb
        00000000 00010ecf dfc28a60 00000000 dfc2a4e0 ffffff90 00000000 cf41a960
Call Trace:
  [<c011e99f>] release_console_sem+0xbf/0xd0
  [<c011b0ef>] __wake_up+0x2f/0x60
  [<c01bf8cb>] SendReceive+0x3eb/0x7c1
  [<c011c200>] autoremove_wake_function+0x0/0x50
  [<c011c200>] autoremove_wake_function+0x0/0x50
  [<c01a963a>] CIFSSMBNegotiate+0xfa/0x320
  [<c010235a>] kernel_thread+0x8a/0xa0
  [<c01b54fb>] cifs_setup_session+0x26b/0x2df
  [<c01b27ea>] cifs_mount+0x76a/0xb70
  [<c0146aac>] do_no_page+0x5c/0x300
  [<c01dde26>] idr_get_new_above_int+0x76/0x110
  [<c01ddefa>] idr_get_new+0xa/0x30
  [<c01a87e9>] cifs_read_super+0x59/0x160
  [<c01a8c32>] cifs_get_sb+0x52/0xb0
  [<c015b1b1>] do_kern_mount+0x51/0xe0
  [<c016fe0a>] do_new_mount+0x8a/0xc0
  [<c01704ac>] do_mount+0x13c/0x180
  [<c0170282>] exact_copy_from_user+0x32/0x60
  [<c0170309>] copy_mount_options+0x59/0xc0
  [<c0170840>] sys_mount+0x90/0x100
  [<c0104089>] sysenter_past_esp+0x52/0x71
Code: ff ff 8d b6 00 00 00 00 55 89 e5 8b 40 04 5d e9 d4 f6 ff ff 8d 74 26 00 
55 89 e5 57 89 c7 56 53 83 ec 10 89 55 f0 89 4d ec 8b 00 <8b> 10 39 f8 89 55 e8 
74 40 8d 74 26 00 8d 58 f4 8b 70 f4 8b 45
  <6>note: mount.cifs[26249] exited with preempt_count 2
bad: scheduling while atomic!
  [<c052d9dc>] schedule+0x4cc/0x4e0
  [<c01454ab>] zap_pmd_range+0x4b/0x70
  [<c011a7c7>] try_to_wake_up+0xa7/0xc0
  [<c014550d>] unmap_page_range+0x3d/0x70
  [<c01456eb>] unmap_vmas+0x1ab/0x1c0
  [<c0149884>] exit_mmap+0x74/0x150
  [<c011c485>] mmput+0x55/0x90
  [<c012057a>] do_exit+0x14a/0x400
  [<c010532d>] die+0x16d/0x170
  [<c0116510>] do_page_fault+0x0/0x56e
  [<c0116510>] do_page_fault+0x0/0x56e
  [<c011672f>] do_page_fault+0x21f/0x56e
  [<c013c8cb>] __alloc_pages+0x1cb/0x340
  [<c011a587>] recalc_task_prio+0x97/0x190
  [<c011a6da>] activate_task+0x5a/0x70
  [<c011a7c7>] try_to_wake_up+0xa7/0xc0
  [<c0116510>] do_page_fault+0x0/0x56e
  [<c0104b5d>] error_code+0x2d/0x38
  [<c011b063>] __wake_up_common+0x13/0x70
  [<c011e99f>] release_console_sem+0xbf/0xd0
  [<c011b0ef>] __wake_up+0x2f/0x60
  [<c01bf8cb>] SendReceive+0x3eb/0x7c1
  [<c011c200>] autoremove_wake_function+0x0/0x50
  [<c011c200>] autoremove_wake_function+0x0/0x50
  [<c01a963a>] CIFSSMBNegotiate+0xfa/0x320
  [<c010235a>] kernel_thread+0x8a/0xa0
  [<c01b54fb>] cifs_setup_session+0x26b/0x2df
  [<c01b27ea>] cifs_mount+0x76a/0xb70
  [<c0146aac>] do_no_page+0x5c/0x300
  [<c01dde26>] idr_get_new_above_int+0x76/0x110
  [<c01ddefa>] idr_get_new+0xa/0x30
  [<c01a87e9>] cifs_read_super+0x59/0x160
  [<c01a8c32>] cifs_get_sb+0x52/0xb0
  [<c015b1b1>] do_kern_mount+0x51/0xe0
  [<c016fe0a>] do_new_mount+0x8a/0xc0
  [<c01704ac>] do_mount+0x13c/0x180
  [<c0170282>] exact_copy_from_user+0x32/0x60
  [<c0170309>] copy_mount_options+0x59/0xc0
  [<c0170840>] sys_mount+0x90/0x100
  [<c0104089>] sysenter_past_esp+0x52/0x71

-- 
Greetings
Bjoern Schmidt

