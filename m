Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262010AbSIYPoM>; Wed, 25 Sep 2002 11:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbSIYPoM>; Wed, 25 Sep 2002 11:44:12 -0400
Received: from gherkin.frus.com ([192.158.254.49]:56704 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S262010AbSIYPoK>;
	Wed, 25 Sep 2002 11:44:10 -0400
Message-Id: <m17uEPg-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.38: oops with kernel LLC support enabled
To: linux-kernel@vger.kernel.org
Date: Wed, 25 Sep 2002 10:49:20 -0500 (CDT)
CC: acme@conectiva.com.br
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, a big thanks to Ingo for kksymoops...  2.5.38 panics right
out of the chute with no way to save the oops output, so it's REALLY
nice to have it decoded on the screen!!  Manual transcription of the
oops output follows below.

What was I trying to do with LLC support?  I have an old JetDirect
interface in a LJ-III that speaks DLC/LLC only, and wanted to try to
use it with Linux.  (It should go without saying that NT and Win2K
can talk to it just fine :-)).  Both machines in a sample set of two
panic the same way...  One is a desktop with the NIC driver built-in.
The other (that produced the oops output below) is a Dell Latitude CPxJ
with a modular Xircom Tulip cardbus driver.

I guess I should mention that I haven't tried this with a 2.4 kernel.

 Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
 c0245da5
 *pde = 00000000
 Oops: 0000
 kernel
 CPU:    0
 EIP:    0060:[<c0245da5>]	Not tainted
 EFLAGS: 00010202
 EIP is at llc_sap_find [kernel] 0x25
 eax: c7fae000   ebx: c02e8e28   ecx: 000000aa   edx: 00000000
 esi: 00000000   edi: 00000000   ebp: 00000000   esp: c7faffa8
 ds: 0068   es: 0068   ss: 0068
 Process swapper (pid: 1, threadinfo=c7fae000 task=c7fac040)
 Stack: c02e8e28 000000aa 00000000 c0242141 000000aa c02e8e28 00000000 c02df8e1
        c01f0ca0 00000000 000000aa c02d0712 c7fae000 c0105093 c0105060 00000000
        00000000 00000000 c01054e5 00000000 00000000 00000000
 Call Trace: [<c0242141>] llc_sap_open [kernel] 0x11
 [<c01f0ca0>] snap_indicate [kernel] 0x0
 [<c0105093>] init [kernel] 0x33
 [<c0105060>] init [kernel] 0x0
 [<c01054e5>] kernel_thread_helper [kernel] 0x5
 
 
 Code: 8b 02 0f 18 00 81 fa 04 69 33 c0 74 08 38 4a f8 8d 72 a0 75
  <0>Kernel panic: Aiee, killing interrupt handler!
 In interrupt handler - not syncing
 
 
-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
