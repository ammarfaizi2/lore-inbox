Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbRGUOlv>; Sat, 21 Jul 2001 10:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbRGUOll>; Sat, 21 Jul 2001 10:41:41 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:3742 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S267642AbRGUOlY>; Sat, 21 Jul 2001 10:41:24 -0400
From: Christoph Rohland <cr@sap.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.7 final
Organisation: SAP LinuxLab
Date: 21 Jul 2001 16:37:42 +0200
Message-ID: <m3k81273gp.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I did my shm stress test the first time since weeks on my 8way/8GB
today. After the usual load of

__alloc_pages: 0-order allocation failed.

It got the following oops:

Unable to handle kernel paging request at virtual address 7061732e
 printing eip:
7061732e
*pde = 00000000
Oops: 0000
CPU:    6
EIP:    0010:[<7061732e>]
EFLAGS: 00010246
eax: 7061732e   ebx: c0633bc0   ecx: 00000001   edx: c0666840
esi: c0633bc0   edi: 00000008   ebp: f75d7400   esp: f6d29cc0
ds: 0018   es: 0018   ss: 0018
Process screen (pid: 630, stackpage=f6d29000)
Stack: c0131e84 c0666840 00000001 f75d74ac c0633bc0 c01b3880 c0633bc0 00000001
       00000008 c060d000 c060d000 f75d7400 c01b3bff f75d7400 00000001 00000000
       00000001 00000001 00000008 00000001 f75d7400 00000000 ccd47200 f75d7400
Trace; c0131e84 <bounce_end_io_write+14/c0>
Trace; c01b3880 <__scsi_end_request+a4/164>
Trace; c01b3bff <scsi_io_completion+1d3/3c0>
Trace; c01b8921 <ncr_complete+4f9/510>
Trace; c01c4176 <rw_intr+1f6/204>
Trace; c01b290d <scsi_old_done+3d/5c8>
Trace; c01b2e7c <scsi_old_done+5ac/5c8>
Trace; c01bd567 <sym53c8xx_intr+87/9c>
Trace; c01084e6 <handle_IRQ_event+4e/78>
Trace; c01086d9 <do_IRQ+99/e4>
Trace; c0106dfc <ret_from_intr+0/7>
Trace; c0220018 <stext_lock+4994/7efc>
Trace; c021d662 <stext_lock+1fde/7efc>
Trace; c012c031 <page_launder+395/930>
Trace; c012c949 <do_try_to_free_pages+1d/58>
Trace; c012cab2 <try_to_free_pages+22/2c>
Trace; c012d6e4 <__alloc_pages+1e0/28c>
Trace; c012d500 <_alloc_pages+18/1c>
Trace; c012d79a <__get_free_pages+a/18>
Trace; c0143b73 <__pollwait+33/94>
Trace; c017b9d4 <normal_poll+28/124>
Trace; c0178573 <tty_poll+8b/98>
Trace; c0143ddb <do_select+14b/234>
Trace; c0144322 <sys_select+436/598>
Trace; c0106d7b <system_call+33/38>
 
Code:  Bad EIP value.
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Greetings
		Christoph


