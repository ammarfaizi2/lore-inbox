Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSFUXEq>; Fri, 21 Jun 2002 19:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSFUXEp>; Fri, 21 Jun 2002 19:04:45 -0400
Received: from holomorphy.com ([66.224.33.161]:25796 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315943AbSFUXEo>;
	Fri, 21 Jun 2002 19:04:44 -0400
Date: Fri, 21 Jun 2002 16:04:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] floppy requests
Message-ID: <20020621230417.GA25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I ran grub to try to install it on a disk to boot elsewhere. Lo
and behold, the legendary robustness of floppy handling bursts forth:

On 2.5.24

Cheers,
Bill

generic_make_request: Trying to access nonexistent block-device fd(2,0) (0)
Unable to handle kernel NULL pointer dereference at virtual address 000000a0
 printing eip:
c023e39d
*pde = 0d6d1001
Oops: 0000
CPU:    1
EIP:    0010:[<c023e39d>]    Not tainted
EFLAGS: 00010002
eax: 00000000   ebx: c95f9e58   ecx: c95f8000   edx: c95f9e60
esi: 00000000   edi: c1175358   ebp: e650fd40   esp: c95f9e2c
ds: 0018   es: 0018   ss: 0018
Process grub (pid: 28571, threadinfo=c95f8000 task=e6ed2060)
Stack: c95f9e58 c95f9e74 c0246ce3 00000000 e650fd40 00000000 c95f9e74 e650fd40
       00000200 00000001 f7570200 00000001 00000001 c95f9e60 c95f9e60 c1175358
       00000400 00000000 00000000 00000000 e650fd40 00000000 00000000 00000001
Call Trace: [<c0246ce3>] [<c0246c20>] [<c0246d62>] [<c0246eb2>] [<c0142d77>]
   [<c0246ae6>] [<c0142f0d>] [<c0143196>] [<c013be51>] [<c013bd66>] [<c013c18b>]
   [<c01089e7>]

Code: 8b 86 a0 00 00 00 f0 fe 08 0f 88 d0 18 00 00 8d 9e 94 00 00
 <6>note: grub[28571] exited with preempt_count 2

