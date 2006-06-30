Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbWF3Bq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWF3Bq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWF3Bq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:46:59 -0400
Received: from narn.hozed.org ([209.234.73.39]:58510 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S932693AbWF3Bq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:46:59 -0400
Date: Thu, 29 Jun 2006 20:46:58 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Subject: more kAFS crashes..
Message-ID: <20060630014658.GD5860@narn.hozed.org>
References: <20060626165843.GA5860@narn.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060626165843.GA5860@narn.hozed.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.17, on PPC64. 

<== afs_mntpt_expiry_timed_out()
reading in unexpected state [[[ 0 ]]]
kernel BUG in __rxrpc_call_read_data at net/rxrpc/call.c:1713!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=32 NUMA
Modules linked in: kafs sd_mod ide_cd cdrom ipr scsi_mod firmware_class
e1000 pdc202xx_new ehci_hcd ohci_hcd usbcore rxrpc
NIP: D000000000054B98 LR: D000000000054B94 CTR: 80000000001AF404
REGS: c0000001e394b9b0 TRAP: 0700   Not tainted  (2.6.17)
MSR: 8000000000029032 <EE,ME,IR,DR>  CR: 22002422  XER: 00000007
TASK = c00000000212b040[297] 'krxiod' THREAD: c0000001e3948000 CPU: 2
GPR00: D000000000054B94 C0000001E394BC30 D000000000074000 0000000000000029
GPR04: 8000000000009032 FFFFFFFFFFFFFFFF 0000000000000007 0000000000000000
GPR08: FFFFFFFFFFFFFFFF C0000000003768D8 C00000000045BC58 C00000000045BB88
GPR12: 0000000000004000 C00000000036A400 C00000000215C3C0 D000000000042C50
GPR16: 0000000000000000 00000000000001E0 D000000000042C10 D000000000063DD0
GPR20: C0000003DA7CE010 C0000003DA7CE010 0000000000000028 D00000000006C0B4
GPR24: C0000001E3DC2400 C0000001E3DC2408 D0000000000422D0 C0000000021909B0
GPR28: C0000003DA7CE1A0 C0000003DA7CE000 D000000000072A80 C0000003DA7CE000
NIP [D000000000054B98] .__rxrpc_call_read_data+0x16c/0x534 [rxrpc]
LR [D000000000054B94] .__rxrpc_call_read_data+0x168/0x534 [rxrpc]
Call Trace:
[C0000001E394BC30] [D000000000054B94]
.__rxrpc_call_read_data+0x168/0x534 [rxrpc] (unreliable)
[C0000001E394BCC0] [D000000000056B78] .rxrpc_call_do_stuff+0x814/0x19d4 [rxrpc]
[C0000001E394BE50] [D00000000005A180] .rxrpc_krxiod+0x32c/0x40c [rxrpc]
[C0000001E394BF90] [C0000000000219DC] .kernel_thread+0x4c/0x68
Instruction dump:
80090000 2f800000 41be03d0 e89e8198 e87e81c0 48009cf5 e8410028 3860ff99
480003b8 e87e81c8 48009ce1 e8410028 <0fe00000> 881d0230 2f800000 409e01ac
 ==> afs_mntpt_expiry_timed_out()

