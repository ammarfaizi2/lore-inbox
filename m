Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTEQXFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 19:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTEQXF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 19:05:29 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:46991 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261878AbTEQXF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 19:05:29 -0400
Subject: CIFS oops in 2.5.69-mm5
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053213497.655.51.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 May 2003 01:18:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven

I just tried mouting a cifs share in 2.5.69-mm5 and got this during the
attempt.

Unable to handle kernel paging request at virtual address 4fb899ce
 printing eip:
eeac8eed
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<eeac8eed>]    Not tainted VLI
EFLAGS: 00010246
EIP is at cifs_demultiplex_thread+0x329/0x4c8 [cifs]
eax: eaf21664   ebx: dbe42450   ecx: eaf21600   edx: 00000000
esi: 0000005b   edi: 0000005b   ebp: c1efffec   esp: c1efffa8
ds: 007b   es: 007b   ss: 0068
Process cifsd (pid: 21104, threadinfo=c1efe000 task=eafeae00)
Stack: eeac8bc4 00000000 00000000 c1efffd0 dfdb5104 c0000000 e4860044 0000005b
       e486009f 00000000 00000000 00000000 c1efffc8 00000001 00000000 00000000
       ffffffff 00000000 c0107111 eaf21600 00000000 00000000
Call Trace:
 [<eeac8bc4>] cifs_demultiplex_thread+0x0/0x4c8 [cifs]
 [<c0107111>] kernel_thread_helper+0x5/0xc

Code: 74 1c 83 3d 84 89 ae ee 00 0f 84 da 00 00 00 68 e0 87 ad ee e9 93 00 00 00 90 8d 74 26 00 31 d2 8b 4d 08 8b 59 64 8b 03 0f 18 00 <00> 89 ce 83 c6 64 39 f3 74 44 8b 4d d4 0f b7 41 22 66 39 43 08

-- 
/Martin
