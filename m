Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUC2GSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 01:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbUC2GSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 01:18:55 -0500
Received: from [210.77.38.126] ([210.77.38.126]:32183 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id S262698AbUC2GSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 01:18:50 -0500
Message-ID: <40683032.2010904@turbolinux.com.cn>
Date: Mon, 29 Mar 2004 14:18:26 +0000
From: "F.Jin" <joej@turbolinux.com.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.5) Gecko/20031230
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Help: [Unable to handle kernel NULL pointer dereference at virtual
 address 00000060]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ALl:
	On Hardware IBM x360 and kernel 2.4.18, kernel panic occur and output info is:

Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL CROND[11122]: (aimc) CMD (/opt/resin/webapps/aipim/aindweb_dog /opt
/opt/aindhttpd /opt/resin b)
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL CROND[11126]: (root) CMD (/opt/aimc/setup/mysql_dog /opt)
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL CROND[11123]: (aimc) CMD (( cd /opt/aildapaddrbook/bin ; ./addrldap_dog /opt 3389
>/dev/null ))
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL CROND[11125]: (aimc) CMD (/opt/aimc/setup/aimc_dog /opt 1)
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL CROND[11124]: (aimc) CMD (/opt/aimc/setup/nodeagent_dog /opt )
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000060
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:  printing eip:
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: 00000060
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: *pde = 00000000
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Oops: 0000
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: CPU:    4
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: EIP:    0010:[<00000060>]    Not tainted
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: EFLAGS: 00010082
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: eax: 00000006   ebx: c8765dc0   ecx: c02f8dfc   edx: c4078000
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: esi: c87ba000   edi: 00000060   ebp: c87bbf24   esp: c87bbefc
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: ds: 0018   es: 0018   ss: 0018
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Process grep (pid: 11151, stackpage=c87bb000)
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Stack: c4079fb4 c035bc00 c4078380 c011c6d5 c403cf60 c87fe000 00000001
c8765dc0
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:        c8765be0 c87ba000 c74180a0 c0159e63 c74180a0 c74180b8 c0159f15
c74180a0
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:        c4c48c40 c76eddc0 c0147403 c74180a0 c4c48c40 00000000 00000000
c62a9920
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Call Trace: [schedule+821/948] [dentry_iput+115/120] [dput+173/284]
[fput+199/232] [filp_close+157/168]
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:    [put_files_struct+79/184] [do_exit+312/764] [sys_exit+15/16]
[system_call+51/64]
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Code:  Bad EIP value.
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:  <1>Unable to handle kernel paging request at virtual address 400edc11
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:  printing eip:
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL CROND[11124]: (aimc) CMD (/opt/aimc/setup/nodeagent_dog /opt )
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000060
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:  printing eip:
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: 00000060
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: *pde = 00000000
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Oops: 0000
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: CPU:    4
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: EIP:    0010:[<00000060>]    Not tainted
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: EFLAGS: 00010082
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: eax: 00000006   ebx: c8765dc0   ecx: c02f8dfc   edx: c4078000
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: esi: c87ba000   edi: 00000060   ebp: c87bbf24   esp: c87bbefc
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: ds: 0018   es: 0018   ss: 0018
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Process grep (pid: 11151, stackpage=c87bb000)
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Stack: c4079fb4 c035bc00 c4078380 c011c6d5 c403cf60 c87fe000 00000001
c8765dc0
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:        c8765be0 c87ba000 c74180a0 c0159e63 c74180a0 c74180b8 c0159f15
c74180a0
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:        c4c48c40 c76eddc0 c0147403 c74180a0 c4c48c40 00000000 00000000
c62a9920
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Call Trace: [schedule+821/948] [dentry_iput+115/120] [dput+173/284]
[fput+199/232] [filp_close+157/168]
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:    [put_files_struct+79/184] [do_exit+312/764] [sys_exit+15/16]
[system_call+51/64]
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel: Code:  Bad EIP value.
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:  <1>Unable to handle kernel paging request at virtual address 400edc11
Mar 25 02:14:00 TJTJ-PB-SV02-17288MAIL kernel:  printing eip:
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: 400edc11
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: *pde = 4bf98067
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: Oops: 0004
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: CPU:    4
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: EIP:    0023:[acpi_system_exit+1074715377/-1072693536]    Not tainted
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: EFLAGS: 00010297
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: eax: 00000000   ebx: bf1ff7d8   ecx: 00000000   edx: 400419dc
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: esi: bf1ff7d8   edi: bf1ff7e0   ebp: bf1ff984   esp: bf1ff7a8
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: ds: 002b   es: 002b   ss: 002b
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: Process grep (pid: 11151, stackpage=c87bb000)
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel:  printing eip:
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: c011c470
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: *pde = 00000000
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: Oops: 0002
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: CPU:    4
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: EIP:    0010:[schedule+208/948]    Not tainted
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: EFLAGS: 00010046
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: eax: 00000004   ebx: c87ba000   ecx: 00000000   edx: 00002700
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: esi: c0365080   edi: c87ba000   ebp: c87bbec0   esp: c87bbea0
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: ds: 0018   es: 0018   ss: 0018
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: Process grep (pid: 11151, stackpage=c87bb000)
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: Stack: 00000000 c87ba000 c87ba000 c87ba000 00000011 00000000 c87ba000
c87ba000
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel:        0000000b c012356f 00000004 c87bbfc4 c029dd2d c87ba000 c0109582
0000000b
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel:        c87ba000 00000000 c011af18 c011b293 c029dd2d c87bbfc4 00000004
c029dd1c
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: Call Trace: [do_exit+751/764] [die+130/132] [do_page_fault+0/1327]
[do_page_fault+891/1327] [do_page_fault+0/1327]
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel:    [dentry_iput+115/120] [dput+173/284] [fput+199/232]
[filp_close+157/168] [put_files_struct+79/184] [do_exit+312/764]
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel:    [error_code+52/64]
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel:
Mar 25 02:14:01 TJTJ-PB-SV02-17288MAIL kernel: Code: ff 09 8b 53 30 8b 43 2c 89 50 04 89 02 8b 53 24 8d 44 d1 18

	And what's wrong? it's a hardware error, or software error?
	Thanks.
Best regards.
Joe

