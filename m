Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSK1HxF>; Thu, 28 Nov 2002 02:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbSK1HxF>; Thu, 28 Nov 2002 02:53:05 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:8064 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S265238AbSK1HxE>;
	Thu, 28 Nov 2002 02:53:04 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Thu, 28 Nov 2002 09:00:21 +0100
To: linux-kernel@vger.kernel.org
Subject: [OOPS] in page_cache_readahead()
Message-ID: <20021128080021.GA365@pc11.op.pod.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  Today I recieved following oops during heavy disk activity in kernel 2.5.49
after two days uptime. Running 2.5.50 to see if it happens again.

Machine:
	SMP 2xPIII/700MHz
	SCSI disks on Adaptec 29160

If you need more info, I'll send it to you.


	Cheers,
		Vita

Unable to handle kernel NULL pointer dereference at virtual address 00000431
 printing eip:
c3000069
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c3000069>]    Not tainted
EFLAGS: 00010212
EIP is at 0xc3000069
eax: cf4db3b4   ebx: c3001e0c   ecx: c013f9eb   edx: c3001e0c
esi: c3001d64   edi: c01f10c0   ebp: 000003d2   esp: c3001e1c
ds: 0068   es: 0068   ss: 0068
Process bk (pid: 23948, threadinfo=c3000000 task=d9863300)
Stack: cd9d56d4 c3001e40 00000012 cd9d5724 00000010 cd9d56d4 cf4db3c4 00000012 
       0000004b c3001e40 c3001e40 cf4db3b4 c013fb08 cf4db3b4 cd9d56d4 00000010 
       00000012 00000005 00000001 cf4db3b4 cd9d56d4 c013fb75 cf4db3b4 cd9d5724 
Call Trace:
 [<c013fb08>] page_cache_readahead+0xf8/0x124
 [<c013fb75>] page_cache_readaround+0x41/0x48
 [<c01318e4>] filemap_nopage+0xdc/0x2b4
 [<c012e589>] do_no_page+0x9d/0x314
 [<c012e8a7>] handle_mm_fault+0xa7/0x168
 [<c0116027>] do_page_fault+0x127/0x424
 [<c0115f00>] do_page_fault+0x0/0x424
 [<c012f632>] do_mmap_pgoff+0x462/0x584
 [<c010f0b1>] sys_mmap2+0x85/0xbc
 [<c010f0df>] sys_mmap2+0xb3/0xbc
 [<c0109809>] error_code+0x2d/0x38

Code: 6b 65 5f 75 70 28 70 2c 20 73 79 6e 63 29 29 3b 0a 7d 0a 0a 
